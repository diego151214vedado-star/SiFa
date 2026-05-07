-- ============================================================
-- SIFA — Esquema Supabase
-- Sin auth · Aislamiento por empresa_id · Offline-first ready
-- ============================================================

-- ── EXTENSIONES ──────────────────────────────────────────────
create extension if not exists "uuid-ossp";

-- ── TABLA: empresas ──────────────────────────────────────────
create table if not exists empresas (
  id              text primary key,           -- key corta: 'dal', 'cate', 'az', 'hc'
  nombre          text not null,
  sub             text,
  ein             text,
  db_prefix       text unique not null,        -- 'dalmiami_', 'cate_', etc.
  direccion       text,
  email           text,
  tel             text,
  color_primary   text default '#6366F1',
  color_secondary text default '#0EA5E9',
  color_accent    text default '#22C55E',
  banco           text,
  swift           text,
  cuenta          text,
  gerente         text,
  cargo_gerente   text,
  presidente      text,
  firma_svg       text,
  cuno_svg        text,
  logo            text,                        -- base64 — puede ser largo
  creado_en       timestamptz default now(),
  actualizado_en  timestamptz default now()
);

-- ── TABLA: clientes ──────────────────────────────────────────
create table if not exists clientes (
  id          text primary key,
  empresa_id  text not null references empresas(id) on delete cascade,
  nombre      text not null,
  cif         text,
  pais        text,
  direccion   text,
  telefono    text,
  email       text,
  notas       text,
  creado_en   timestamptz default now(),
  actualizado_en timestamptz default now()
);
create index if not exists idx_clientes_empresa on clientes(empresa_id);

-- ── TABLA: mercancias ────────────────────────────────────────
create table if not exists mercancias (
  id          text primary key,
  empresa_id  text not null references empresas(id) on delete cascade,
  nombre      text not null,
  codigo      text,
  unidad      text default 'KG',
  precio      numeric(12,4) default 0,
  categoria   text,
  descripcion text,
  creado_en   timestamptz default now(),
  actualizado_en timestamptz default now()
);
create index if not exists idx_mercancias_empresa on mercancias(empresa_id);

-- ── TABLA: facturas ──────────────────────────────────────────
-- Facturas simples (módulo legacy 2601, 2602...)
create table if not exists facturas (
  id           text primary key,
  empresa_id   text not null references empresas(id) on delete cascade,
  invoice_id   text,                           -- vinculada a invoice FA-xxxx si aplica
  fecha        date not null,
  numero       text not null,
  cliente_id   text references clientes(id) on delete set null,
  mercancia_id text references mercancias(id) on delete set null,
  deuda        numeric(14,2) default 0,
  arrastre     numeric(14,2) default 0,
  estatus      text,
  creado_en    timestamptz default now(),
  actualizado_en timestamptz default now()
);
create index if not exists idx_facturas_empresa on facturas(empresa_id);
create index if not exists idx_facturas_cliente on facturas(cliente_id);

-- ── TABLA: pagos ─────────────────────────────────────────────
create table if not exists pagos (
  id          text primary key,
  empresa_id  text not null references empresas(id) on delete cascade,
  factura_id  text references facturas(id) on delete cascade,
  fecha       date not null,
  monto       numeric(14,2) not null,
  notas       text,
  creado_en   timestamptz default now(),
  actualizado_en timestamptz default now()
);
create index if not exists idx_pagos_empresa   on pagos(empresa_id);
create index if not exists idx_pagos_factura   on pagos(factura_id);

-- ── TABLA: invoices ──────────────────────────────────────────
-- Documentos FA-xxxx (financieros) y OF-xxxx (ofertas/complementarios)
create table if not exists invoices (
  id              text primary key,
  empresa_id      text not null references empresas(id) on delete cascade,
  tipo_key        text not null default 'I',   -- 'F','I','O','C' u otro
  titulo          text,
  fecha           date not null,
  numero          text not null,
  cliente_id      text references clientes(id) on delete set null,
  moneda          text default 'USD',
  emisora_key     text references empresas(id) on delete set null,
  proveedor       text,
  lineas          jsonb not null default '[]', -- array de líneas de producto
  subtotal        numeric(14,2) default 0,
  flete           numeric(14,2) default 0,
  seguro          numeric(14,2) default 0,
  total           numeric(14,2) default 0,
  consignatario   text,
  condicion       text,
  incoterm        text,
  origen          text,
  puerto          text,
  peso            text,
  bultos          text,
  notas           text,
  entregado_por   text,
  convertida      boolean default false,
  factura_generada text,
  oferta_origen   text,
  creado_en       timestamptz default now(),
  actualizado_en  timestamptz default now()
);
create index if not exists idx_invoices_empresa  on invoices(empresa_id);
create index if not exists idx_invoices_cliente  on invoices(cliente_id);
create index if not exists idx_invoices_tipo     on invoices(empresa_id, tipo_key);

-- ── TABLA: calculos ──────────────────────────────────────────
create table if not exists calculos (
  id               text primary key,
  empresa_id       text not null references empresas(id) on delete cascade,
  fecha            date,
  ref              text,
  prod_id          text references mercancias(id) on delete set null,
  prod_nombre      text,
  costo            numeric(12,4),
  margen           numeric(8,2),
  flete            numeric(14,2),
  kg               numeric(12,3),
  costo_total      numeric(14,2),
  subtotal         numeric(14,2),
  precio_contenedor numeric(14,2),
  precio_kilo      numeric(12,4),
  precio_venta     numeric(12,4),
  utilidad_kg      numeric(12,4),
  utilidad         numeric(14,2),
  creado_en        timestamptz default now(),
  actualizado_en   timestamptz default now()
);
create index if not exists idx_calculos_empresa on calculos(empresa_id);

-- ── TABLA: anticipos ─────────────────────────────────────────
create table if not exists anticipos (
  id          text primary key,
  empresa_id  text not null references empresas(id) on delete cascade,
  fecha       date,
  cliente_id  text references clientes(id) on delete set null,
  monto       numeric(14,2),
  origen      text,
  aplicado    boolean default false,
  creado_en   timestamptz default now(),
  actualizado_en timestamptz default now()
);
create index if not exists idx_anticipos_empresa on anticipos(empresa_id);

-- ── TABLA: sync_log ──────────────────────────────────────────
-- Registro de cambios pendientes para sync offline→online
create table if not exists sync_log (
  id          bigint generated always as identity primary key,
  empresa_id  text not null,
  tabla       text not null,                   -- 'clientes','facturas', etc.
  operacion   text not null,                   -- 'upsert' | 'delete'
  registro_id text not null,
  payload     jsonb,
  synced      boolean default false,
  creado_en   timestamptz default now()
);
create index if not exists idx_sync_log_pendiente on sync_log(synced, empresa_id);

-- ── FUNCIÓN: updated_at automático ───────────────────────────
create or replace function set_actualizado_en()
returns trigger as $$
begin
  new.actualizado_en = now();
  return new;
end;
$$ language plpgsql;

-- Triggers actualizado_en (idempotente)
drop trigger if exists trg_empresas_upd   on empresas;
drop trigger if exists trg_clientes_upd   on clientes;
drop trigger if exists trg_mercancias_upd on mercancias;
drop trigger if exists trg_facturas_upd   on facturas;
drop trigger if exists trg_pagos_upd      on pagos;
drop trigger if exists trg_invoices_upd   on invoices;
drop trigger if exists trg_calculos_upd   on calculos;
drop trigger if exists trg_anticipos_upd  on anticipos;

create trigger trg_empresas_upd   before update on empresas   for each row execute function set_actualizado_en();
create trigger trg_clientes_upd   before update on clientes   for each row execute function set_actualizado_en();
create trigger trg_mercancias_upd before update on mercancias for each row execute function set_actualizado_en();
create trigger trg_facturas_upd   before update on facturas   for each row execute function set_actualizado_en();
create trigger trg_pagos_upd      before update on pagos      for each row execute function set_actualizado_en();
create trigger trg_invoices_upd   before update on invoices   for each row execute function set_actualizado_en();
create trigger trg_calculos_upd   before update on calculos   for each row execute function set_actualizado_en();
create trigger trg_anticipos_upd  before update on anticipos  for each row execute function set_actualizado_en();

-- ── RLS: desactivado (sin auth, acceso por anon key) ─────────
-- IMPORTANTE: SiFa usa la anon key de Supabase directamente.
-- No actives RLS a menos que implementes auth después.
alter table empresas   disable row level security;
alter table clientes   disable row level security;
alter table mercancias disable row level security;
alter table facturas   disable row level security;
alter table pagos      disable row level security;
alter table invoices   disable row level security;
alter table calculos   disable row level security;
alter table anticipos  disable row level security;
alter table sync_log   disable row level security;

-- ── GRANT anon ───────────────────────────────────────────────
grant select, insert, update, delete on all tables in schema public to anon;
grant usage on all sequences in schema public to anon;

-- ── SEED: empresas del backup 2026-04-29 ─────────────────────
insert into empresas (id, nombre, sub, ein, db_prefix, direccion, email, tel, color_primary, color_secondary, color_accent, banco, swift, cuenta, gerente, cargo_gerente, presidente) values
(
  'dal',
  'DAL MIAMI EXPORT LLC',
  'Export LLC — Libro de Asiento',
  'EIN: 93-1412443',
  'dalmiami_',
  '3901 SW 78th CT Miami FL-33155',
  'dalmiami9@gmail.com',
  '+1 786-839-1403',
  '#e02020', '#2060c0', '#202020',
  'JPMORGAN CHASE BANK, N.A', '267084131', '960559521 USD',
  'Diego Hernández', 'Gerente Financiero', 'Alejandro De Lara'
),
(
  'hc',
  'HCDAISLA SL',
  'Libro de Asiento',
  'NIF: B72720071',
  'hcdaisla_',
  'VILADECANS, 35, P1, P2 · CP:08014 · Barcelona, Spain',
  null, null,
  '#1565C0', '#E65100', '#22C55E',
  null, null, null,
  null, 'Gerente', null
),
(
  'az',
  'Az-Mercado Familiar',
  'Libro de Asiento',
  null,
  'az_',
  null, null, null,
  '#6366F1', '#0EA5E9', '#22C55E',
  null, null, null,
  null, 'Gerente', null
),
(
  'cate',
  'La Catedral SURL',
  'Libro de Asiento',
  null,
  'cate_',
  null, null, null,
  '#6366F1', '#0EA5E9', '#22C55E',
  null, null, null,
  null, 'Socio Único', null
)
on conflict (id) do nothing;

-- ============================================================
-- FIN DEL ESQUEMA
-- Próximo paso: correr sifa_seed_data.sql con los datos reales
-- ============================================================

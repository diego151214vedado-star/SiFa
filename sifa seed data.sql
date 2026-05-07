-- ============================================================
-- SIFA — Seed de datos reales (backup 2026-04-29)
-- Ejecutar DESPUÉS de sifa_supabase.sql
-- ============================================================


-- ── DAL MIAMI EXPORT LLC (dal) ──────────────────────────────

-- clientes (4)
insert into clientes (id, empresa_id, nombre, cif, pais, direccion, telefono, email, notas) values
  ('mo9sye788uw1azyvi3u', 'dal', 'La Catedral SURL', '50004348171', 'Cuba', 'Calle 8 entre Calazada y 5ta, Plaza, La Habana', '+5352832090', 'catedralrestaurantecuba@gmail.com', ''),
  ('mo9sye78q8octpmjl99', 'dal', 'CEDA SURL', '50004244884', 'Cuba', 'Santo Tomas y Subirana, Centro Habana', '+53 5 2581003', 'cedasubirana@gmail.com', ''),
  ('mo9sye780o9eau46z3zj', 'dal', 'Santa Barbara SURL', '', 'Cuba', 'Calle M entre linea y 17, Plaza, La Habana', '+53 5 2645177', '', ''),
  ('mo9sye78m9jg6xyhc38', 'dal', 'MERCY SURL', null, 'Cuba', null, null, null, null)
on conflict (id) do nothing;

-- mercancias (5)
insert into mercancias (id, empresa_id, nombre, codigo, unidad, precio, categoria, descripcion) values
  ('mo9satc69urowiwdae5', 'dal', 'Frozen 4x10 Lb Poly- Bagged', '', 'KG', 0, 'Pollo', ''),
  ('mo9sye78pb74h8bsdu', 'dal', 'Frozen 4x10 Lb PolyBagged', null, 'Caja', 0, 'Alimentos', 'Pollo congelado 4x10 Lb en bolsa'),
  ('mo9sye7806ql2i6vv6fy', 'dal', 'Frozen Pork Boneless Loin', null, 'KG', 0, 'Alimentos', 'Lomo de cerdo deshuesado congelado'),
  ('mo9sye78jbdr29ol7o', 'dal', 'Sanderson Farms Frozen Half Bird', null, 'Caja', 0, 'Alimentos', 'Pollo entero Sanderson Farms congelado, medio'),
  ('moa14lrxze7mllcptu', 'dal', 'Frozen 4x10 Lb Poly-Bagged', null, 'Caja', 0, 'Pollo', 'Pollo congelado 4x10 Lb en bolsa')
on conflict (id) do nothing;

-- facturas (10)
insert into facturas (id, empresa_id, invoice_id, fecha, numero, cliente_id, mercancia_id, deuda, arrastre, estatus) values
  ('mo9sye78dlrqb2utm2e', 'dal', null, '2026-01-12', '2601', 'mo9sye788uw1azyvi3u', 'moa14lrxze7mllcptu', 18627.9, 0, 'Pagado'),
  ('mo9sye78u0ataqo6keh', 'dal', null, '2026-01-12', '2602', 'mo9sye78q8octpmjl99', 'moa14lrxze7mllcptu', 18627.9, 0, 'Pagado'),
  ('mo9sye78g7zukokv2hi', 'dal', null, '2026-01-12', '2603', 'mo9sye78m9jg6xyhc38', 'moa14lrxze7mllcptu', 18627.9, 0, 'Pagado'),
  ('mo9sye78ip94gsj1qgc', 'dal', null, '2026-01-12', '2604', 'mo9sye780o9eau46z3zj', 'moa14lrxze7mllcptu', 18627.9, 0, 'Pagado'),
  ('mo9sye788dfjrvow64', 'dal', null, '2026-02-15', '2605', 'mo9sye788uw1azyvi3u', 'mo9sye7806ql2i6vv6fy', 33176, 0, 'Pagado parcialmente'),
  ('mo9sye78fg71fb6op6t', 'dal', null, '2026-02-15', '2606', 'mo9sye78q8octpmjl99', 'mo9sye7806ql2i6vv6fy', 33168, 0, 'Pagado parcialmente'),
  ('mo9sye78gsoz1fsq2qm', 'dal', null, '2026-02-15', '2607', 'mo9sye78m9jg6xyhc38', 'mo9sye7806ql2i6vv6fy', 33172, 0, 'Pagado parcialmente'),
  ('mo9sye7805el11envunk', 'dal', null, '2026-04-08', '2608', 'mo9sye788uw1azyvi3u', 'mo9sye78jbdr29ol7o', 12372.75, 0, 'Pendiente'),
  ('mo9sye78uch4xlkbqg', 'dal', null, '2026-04-08', '2609', 'mo9sye78q8octpmjl99', 'mo9sye78jbdr29ol7o', 12372.75, 0, 'Pendiente'),
  ('mo9sye78p72z8iuvcnj', 'dal', null, '2026-04-08', '2610', 'mo9sye78m9jg6xyhc38', 'mo9sye78jbdr29ol7o', 12351.6, 0, 'Pendiente')
on conflict (id) do nothing;

-- pagos (12)
insert into pagos (id, empresa_id, factura_id, fecha, monto, notas) values
  ('p001', 'dal', 'mo9sye78dlrqb2utm2e', '2026-01-15', 19467.3, 'CHASE BANK'),
  ('p002', 'dal', 'mo9sye78u0ataqo6keh', '2026-01-15', 18627.9, 'Chase bank'),
  ('p003', 'dal', 'mo9sye78ip94gsj1qgc', '2026-01-15', 18627.9, 'Pago recibido'),
  ('p004', 'dal', 'mo9sye78fg71fb6op6t', '2026-03-02', 20000, 'Pago recibido'),
  ('p005', 'dal', 'mo9sye78gsoz1fsq2qm', '2026-03-02', 10000, 'Pago recibido'),
  ('p006', 'dal', 'mo9sye788dfjrvow64', '2026-03-16', 28275.16, 'Pago recibido'),
  ('p007', 'dal', 'mo9sye78g7zukokv2hi', '2026-04-02', 20000, 'Chase bank'),
  ('p008', 'dal', 'mo9sye78gsoz1fsq2qm', '2026-04-05', 14974.5, 'THE BANK OF NEW YORK MELLON — Caribbean Online Services'),
  ('p009', 'dal', 'mo9sye788dfjrvow64', '2026-04-22', 4900.84, 'Wire Caribbean Online Services 22/04'),
  ('p010', 'dal', 'mo9sye7805el11envunk', '2026-04-22', 12372.75, 'Wire Caribbean Online Services 22/04'),
  ('p011', 'dal', 'mo9sye78fg71fb6op6t', '2026-04-22', 5540.75, 'Wire Caribbean Online Services 22/04'),
  ('p012', 'dal', 'mo9sye78gsoz1fsq2qm', '2026-04-22', 6825.4, 'Wire Caribbean Online Services 22/04')
on conflict (id) do nothing;

-- ── HCDAISLA SL (hc) ──────────────────────────────

-- ── Az-Mercado Familiar (az) ──────────────────────────────

-- clientes (1)
insert into clientes (id, empresa_id, nombre, cif, pais, direccion, telefono, email, notas) values
  ('mo7gv9sbdjjfi5a7evt', 'az', 'TL38 S.U.R.L', '50004195419', 'Cuba', 'CARRETERA EL GLOBO #125E. CARRETERA MANAGUA. LAS GUASIMAS. ARROYO NARANJ', '', '', '')
on conflict (id) do nothing;

-- mercancias (1)
insert into mercancias (id, empresa_id, nombre, codigo, unidad, precio, categoria, descripcion) values
  ('mo7gqqctcodzeg04lqm', 'az', 'Muslo de pollo caja 15 kG Sanderson Farms', '1079460569189', 'Caja', 30, 'Pollo', '')
on conflict (id) do nothing;

-- invoices (2)
insert into invoices (id, empresa_id, tipo_key, titulo, fecha, numero, cliente_id, moneda, emisora_key, proveedor, lineas, subtotal, flete, seguro, total, consignatario, condicion, incoterm, origen, puerto, peso, bultos, notas, entregado_por, convertida, factura_generada) values
  ('mo7hlpyyg3h6d3w6bqk', 'az', 'O', 'ORDEN DE ENTREGA', '2026-04-20', '2627', '', 'USD', null, '', '[{"prodId": "mo7gqqctcodzeg04lqm", "nombre": "Muslo de pollo caja 15 kG Sanderson Farms", "codigo": "1079460569189", "um": "Caja", "qty": 40, "price": 30, "importe": 1200}]'::jsonb, 1200, 0, 0, 1200, '', '', '', '', '', '600', '40', '', null, false, null),
  ('mo9ry3u8uofgvj362f', 'az', 'F', 'FACTURA', '2026-04-22', 'F0001', '', 'USD', 'az', '', '[{"prodId": "mo7gqqctcodzeg04lqm", "nombre": "Muslo de pollo caja 15 kG Sanderson Farms", "codigo": "1079460569189", "um": "Caja", "qty": 1, "price": 30, "importe": 30}]'::jsonb, 30, 0, 0, 30, '', '', '', '', '', '', '', '', 'Nelson Pimentel', false, null)
on conflict (id) do nothing;

-- ── La Catedral SURL (cate) ──────────────────────────────

-- clientes (2)
insert into clientes (id, empresa_id, nombre, cif, pais, direccion, telefono, email, notas) values
  ('mo7ohq5472dfg5oihlu', 'cate', 'CARIBBEAN ONLINE SERVICES S.L.', 'B19922293', 'España', 'Avenida de los Andes, 17, Escalera 6, Planta 2, Puerta C, 28043 Madrid, Espa', '', '', ''),
  ('mobj63i7hyhj4e5iyq9', 'cate', 'TREEW INC', 'Ontario Corporation Number (OCN): 1548942', 'Ontario, Canada', '18 Spring Garden Avenue', '', '', '')
on conflict (id) do nothing;

-- mercancias (9)
insert into mercancias (id, empresa_id, nombre, codigo, unidad, precio, categoria, descripcion) values
  ('mo7o7wz1fygfuwss1vm', 'cate', 'Bistec de res AZ (3Lbs )', 'B-JAM-001-1049', 'Unidad', 14.97, 'Res', ''),
  ('mo7o9l1uvde8k7nautg', 'cate', 'Carne troceada de res AZ (3lbs)', 'B-JAM-001-1050', 'Unidad', 13.61, 'Res', ''),
  ('mo7oaq0gmenuoc1qx', 'cate', 'Picadillo de res (3lbs)', 'B-JAM-001-1048', 'Unidad', 12.25, 'Res', ''),
  ('mo7obyvl1jhcmf5f0qb', 'cate', 'Chuletas de cerdo AZ (3lbs)', '', 'Unidad', 8, 'Cerdo', ''),
  ('mo8z405az0nh38ap7re', 'cate', 'Lomo de cerdo AZ 3Lbs', 'B-JAM-001-1116', 'Unidad', 8, 'Cerdo', ''),
  ('mo8z59c0zlzq855jx5j', 'cate', 'Lomo de cerdo AZ 5lbs', 'B-JAM-001-1117', 'Unidad', 13.33, 'Cerdo', ''),
  ('mo8z74437xappnixwb', 'cate', 'Lomo de cerdo AZ 8lbs', 'B-JAM-001-1118', 'Unidad', 21.33, 'Cerdo', ''),
  ('mocw0thztnctrcxj7l', 'cate', 'Concepto por ventas en comercio electronico', '', 'Unidad', 0, 'Producto', ''),
  ('modnljottbsu06mrr7h', 'cate', 'Aceite de Girazol NAZ (1 LT)', 'B-JAM-001-1037', 'KG', 2.3, 'Alimentos', '')
on conflict (id) do nothing;

-- facturas (1)
insert into facturas (id, empresa_id, invoice_id, fecha, numero, cliente_id, mercancia_id, deuda, arrastre, estatus) values
  ('mocxgnskh17c36pa4ki', 'cate', 'mocxgnsk1vquryyusrh', '2026-04-24', 'F0002', 'mobj63i7hyhj4e5iyq9', 'mocw0thztnctrcxj7l', 3936978.0799999996, 0, null)
on conflict (id) do nothing;

-- invoices (5)
insert into invoices (id, empresa_id, tipo_key, titulo, fecha, numero, cliente_id, moneda, emisora_key, proveedor, lineas, subtotal, flete, seguro, total, consignatario, condicion, incoterm, origen, puerto, peso, bultos, notas, entregado_por, convertida, factura_generada) values
  ('mo7omfpyezqkmhpb8bj', 'cate', 'O', 'ORDEN DE ENTREGA', '2026-04-20', 'O00024', 'mo7ohq5472dfg5oihlu', 'USD', null, '', '[{"prodId": "mo7o7wz1fygfuwss1vm", "nombre": "Bistec de res AZ (3Lbs )", "codigo": "B-JAM-001-1049", "um": "Unidad", "qty": 50, "price": 14.97, "importe": 748.5}, {"prodId": "mo7o9l1uvde8k7nautg", "nombre": "Carne troceada de res AZ (3lbs)", "codigo": "B-JAM-001-1050", "um": "Unidad", "qty": 40, "price": 13.61, "importe": 544.4}, {"prodId": "mo7oaq0gmenuoc1qx", "nombre": "Picadillo de res (3lbs)", "codigo": "B-JAM-001-1048", "um": "Unidad", "qty": 30, "price": 12.25, "importe": 367.5}, {"prodId": "mo7obyvl1jhcmf5f0qb", "nombre": "Chuletas de cerdo AZ (3lbs)", "codigo": "B-JAM-001-1132", "um": "Unidad", "qty": 40, "price": 8, "importe": 320}]'::jsonb, 1980.4, 0, 0, 1980.4, '', '', '', '', '', '', '', 'Mercancías en consignacion', null, false, null),
  ('mo8zb26jq2gi69bbafg', 'cate', 'O', 'ORDEN DE ENTREGA', '2026-04-21', 'O0025', 'mo7ohq5472dfg5oihlu', 'USD', null, '', '[{"prodId": "mo8z405az0nh38ap7re", "nombre": "Lomo de cerdo AZ 3Lbs", "codigo": "B-JAM-001-1116", "um": "Unidad", "qty": 50, "price": 8, "importe": 400}, {"prodId": "mo8z59c0zlzq855jx5j", "nombre": "Lomo de cerdo AZ 5lbs", "codigo": "B-JAM-001-1117", "um": "Unidad", "qty": 40, "price": 13.33, "importe": 533.2}, {"prodId": "mo8z74437xappnixwb", "nombre": "Lomo de cerdo AZ 8lbs", "codigo": "B-JAM-001-1118", "um": "Unidad", "qty": 30, "price": 21.33, "importe": 639.9}]'::jsonb, 1573.1, 0, 0, 1573.1, '', '', '', '', '', '', '', 'Entrega en consignacion a: CEDA surl , santo Tomas y Subirana, Centro Habana', null, false, null),
  ('mocxgnsk1vquryyusrh', 'cate', 'F', 'FACTURA', '2026-04-24', 'F0002', 'mobj63i7hyhj4e5iyq9', 'CUP', 'cate', '', '[{"prodId": "mocw0thztnctrcxj7l", "nombre": "Concepto por ventas en comercio electronico", "codigo": "", "um": "Unidad", "qty": 644, "price": 6113.32, "importe": 3936978.0799999996}]'::jsonb, 3936978.0799999996, 0, 0, 3936978.0799999996, '', '', '', '', '', '', '', '', '', false, null),
  ('moe8hqzk9cmlm8i0fk', 'cate', '', 'Orden de Entrega', '2026-04-25', '00026', 'mo7ohq5472dfg5oihlu', 'USD', 'cate', '', '[{"prodId": "modnljottbsu06mrr7h", "nombre": "Aceite de Girazol NAZ (1 LT)", "codigo": "B-JAM-001-1037", "um": "KG", "qty": 1200, "price": 2.3, "importe": 2760}]'::jsonb, 2760, 0, 0, 2760, '', '', '', '', '', '', '', 'ALmacen de clavel', 'Nelson Pimentel', false, null),
  ('mokmx030wy5e59dxdj', 'cate', 'O', 'ORDEN DE ENTREGA', '2026-04-29', 'O0027', 'mo7ohq5472dfg5oihlu', 'USD', 'cate', '', '[{"prodId": "modnljottbsu06mrr7h", "nombre": "Aceite de Girazol NAZ (1 LT)", "codigo": "B-JAM-001-1037", "um": "KG", "qty": 1200, "price": 2.3, "importe": 2760}]'::jsonb, 2760, 0, 0, 2760, '', 'Consignacion', '', '', '', '1200', '1200', '', 'Nelson Pimentel', false, null)
on conflict (id) do nothing;

-- ============================================================
-- FIN SEED
-- ============================================================
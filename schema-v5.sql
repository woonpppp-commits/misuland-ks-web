-- ===== Misuland กำแพงแสน — เพิ่มระบบ "เปิด/ปิดเมนู" (วัตถุดิบหมด) =====
-- รันเพิ่มใน Supabase → SQL Editor → New query → วาง → Run (ครั้งเดียว)
-- ต่างจาก round_state: menu_state เก็บถาวร (คีย์ตามชื่อเมนู ไม่ผูกวัน)
-- ปิดแล้วปิดค้างจนกดเปิดใหม่ → เหมาะกับ "ของหมดหลายวัน" / เลิกขายเมนูนั้น

create table if not exists public.menu_state (
  item       text primary key,              -- ชื่อเมนู (ตรงกับ MENU ใน index.html)
  available  boolean not null default true,  -- true = พร้อมขาย · false = ปิด (วัตถุดิบหมด)
  updated_at timestamptz not null default now()
);

alter table public.menu_state enable row level security;

create policy "ms anon select" on public.menu_state for select to anon using (true);
create policy "ms anon insert" on public.menu_state for insert to anon with check (true);
create policy "ms anon update" on public.menu_state for update to anon using (true) with check (true);
create policy "ms anon delete" on public.menu_state for delete to anon using (true);

-- เปิด realtime (หน้าลูกค้าซ่อนเมนูทันทีเมื่อร้านกดปิด)
alter publication supabase_realtime add table public.menu_state;

-- ===== Misuland กำแพงแสน — อนุญาตลบออเดอร์ (Dashboard) =====
-- รันเพิ่มใน Supabase → SQL Editor → New query → วาง → Run (ครั้งเดียว)
-- *** จำเป็นต้องรัน *** ไม่งั้นปุ่ม "🗑 ลบ" / "🗑 ล้างวันนี้" ในหน้า Dashboard
-- จะกดแล้วไม่มีอะไรเกิดขึ้น (RLS บล็อกการลบเพราะยังไม่มี policy)

create policy "anon delete" on public.orders
  for delete to anon using (true);

create policy "rs anon delete" on public.round_state
  for delete to anon using (true);

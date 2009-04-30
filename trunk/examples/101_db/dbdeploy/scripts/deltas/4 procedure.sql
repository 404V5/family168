create or replace procedure p_pay_month(i_month in varchar2) is
  i_division         varchar2(100);
  i_sign_count       number(9);
  i_consign_count    number(9);
  i_stay_buy_price   double precision;
  i_total_price      double precision;
  i_real_price       double precision;
  i_first_price      double precision;
  i_save_price       double precision;
  i_hand_price       double precision;
  i_insure_price     double precision;
  i_pub_price        double precision;
  i_last_month_price double precision;
  i_month_price      double precision;
  i_month_real_price double precision;
  i_dun_price        double precision;
  i_year_dun_rate    double precision;
  i_ren_price        double precision;
  i_penalty          double precision;
  cursor v_cur1 is
    select c.division as division
      from fil_contract c
     group by c.division
     order by c.division;
begin
  delete from fil_report_pay_month where month = i_month;
  open v_cur1;
  loop
    -- ��ҵ��
    fetch v_cur1
      into i_division;
    -- ǩ��̨��
    -- �豸������
    -- ������ͬ�ܽ��
    select count(e.id), sum(e.staybuy_price), sum(e.unit_price)
      into i_sign_count, i_stay_buy_price, i_total_price
      from fil_equipment e, fil_contract c
     where c.division = i_division and e.contract_id = c.id and
           e.letter_of_advice_id is null and
           substr(c.lessor_time, 0, 7) = i_month;
    -- ����̨��
    -- ʵ�ʷ�����
    select count(e.id), sum(e.unit_price)
      into i_consign_count, i_real_price
      from fil_equipment e, fil_contract c, fil_letter_of_advice loa
     where c.division = i_division and e.contract_id = c.id and
           to_char(loa.tab_date, 'yyyy-MM') = i_month;
    -- �������
    select sum(pad.realpay_money)
      into i_first_price
      from fil_contract c, fil_pay_auto_decompose pad
     where pad.lease_code = c.lease_code and c.division = i_division and
           pad.project_item = '�������' and
           to_char(pad.pay_date, 'yyyy-MM') = i_month;
    -- ��֤��
    select sum(pad.realpay_money)
      into i_save_price
      from fil_contract c, fil_pay_auto_decompose pad
     where pad.lease_code = c.lease_code and c.division = i_division and
           pad.project_item = '��֤��' and
           to_char(pad.pay_date, 'yyyy-MM') = i_month;
    -- ������
    select sum(pad.realpay_money)
      into i_hand_price
      from fil_contract c, fil_pay_auto_decompose pad
     where pad.lease_code = c.lease_code and c.division = i_division and
           pad.project_item = '������' and
           to_char(pad.pay_date, 'yyyy-MM') = i_month;
    -- ���շ�
    select sum(pad.realpay_money)
      into i_insure_price
      from fil_contract c, fil_pay_auto_decompose pad
     where pad.lease_code = c.lease_code and c.division = i_division and
           pad.project_item = '���շ�' and
           to_char(pad.pay_date, 'yyyy-MM') = i_month;
    -- ������
    select sum(pad.realpay_money)
      into i_pub_price
      from fil_contract c, fil_pay_auto_decompose pad
     where pad.lease_code = c.lease_code and c.division = i_division and
           pad.project_item = '������' and
           to_char(pad.pay_date, 'yyyy-MM') = i_month;

    -- ��ֹ����Ӧ�����
    select sum(p.month_price)
      into i_last_month_price
      from fil_contract c, fil_pay_parameter pp, fil_payline p
     where c.division = i_division and c.id = pp.contract_id and
           pp.id = p.pay_id and to_char(p.pay_date, 'yyyy-MM') < i_month;
    -- ����Ӧ�����
    select sum(p.month_price)
      into i_last_month_price
      from fil_contract c, fil_pay_parameter pp, fil_payline p
     where c.division = i_division and c.id = pp.contract_id and
           pp.id = p.pay_id and to_char(p.pay_date, 'yyyy-MM') = i_month;
    -- ����ʵ�����
    select sum(pad.realpay_money)
      into i_month_real_price
      from fil_contract c, fil_pay_auto_decompose pad
     where pad.lease_code = c.lease_code and c.division = i_division and
           (substr(pad.project_item, 7, 9) = '����' or
           substr(pad.project_item, 7, 9) = '��Ϣ') and
           to_char(pad.pay_date, 'yyyy-MM') = i_month;
    -- ������ڽ��
    select sum(dow.penalty)
      into i_dun_price
      from fil_contract         c,
           fil_dun_overdue_warn dow,
           fil_payline          p,
           fil_pay_parameter    pp
     where dow.payline_id = p.id and p.pay_id = pp.id and
           pp.contract_id = c.id and c.division = i_division and
           to_char(dow.pay_date, 'yyyy-MM') = i_month;
    -- �����������
    select 100 *
           (select count(*)
              from fil_dun_overdue_warn
             where to_char(pay_date, 'yyyy') = substr(i_month, 0, 4)) /
           (select count(*)
              from fil_payline fp
             where to_char(pay_date, 'yyyy') = substr(i_month, 0, 4))
      into i_year_dun_rate
      from dual;
    -- ������Ϣ
    select sum(p.ren_price)
      into i_ren_price
      from fil_contract c, fil_pay_parameter pp, fil_payline p
     where c.division = i_division and c.id = pp.contract_id and
           pp.id = p.pay_id and to_char(p.pay_date, 'yyyy-MM') <= i_month;
    -- ���շ�Ϣ
    select sum(pad.realpay_money)
      into i_penalty
      from fil_contract c, fil_pay_auto_decompose pad
     where pad.lease_code = c.lease_code and c.division = i_division and
           substr(pad.project_item, 7, 9) = '���Ϣ' and
           to_char(pad.pay_date, 'yyyy-MM') <= i_month;
    -- ��ǰ����̨��
    -- ��ʱ��ҵ������
    -- ��������ڽ��
    -- ��ǰ����Ӧ��
    -- ��ǰ����ʵ��
    -- δʵ����������
    -- ��ʵ����������
    insert into fil_report_pay_month
      (division,
       sign_count,
       consign_count,
       stay_buy_price,
       total_price,
       real_price,
       first_price,
       save_price,
       hand_price,
       insure_price,
       pub_price,
       last_month_price,
       month_price,
       dun_price,
       year_dun_rate,
       ren_price,
       penalty,
       month)
    values
      (i_division,
       i_sign_count,
       i_consign_count,
       i_stay_buy_price,
       i_total_price,
       i_real_price,
       i_first_price,
       i_save_price,
       i_hand_price,
       i_insure_price,
       i_pub_price,
       i_last_month_price,
       i_month_price,
       i_dun_price,
       i_year_dun_rate,
       ren_price,
       penalty,
       i_month);
    exit when v_cur1%notfound;
  end loop;
  close v_cur1;

  commit;
exception
  when others then
    rollback;
end p_pay_month;
/

--//@UNDO

drop procedure p_pay_month;
/

select t.taxRecord_rate as g0, t2rp1 as g1, min(c.customer_balance) as p0 from TaxRecordView t left outer join AddressView a on t.taxRecord_addressId = a.address_id left outer join CustomerView c on a.address_customerId = c.customer_id left outer join ( select min(o.order_placedOn) as t1rp1, t.taxRecord_id as t1pk from TaxRecordView t left outer join AddressView a on t.taxRecord_addressId = a.address_id left outer join OrderView o on a.address_customerId = o.order_customerId group by t.taxRecord_id ) t1 on t.taxRecord_id = t1pk left outer join ( select sum(p.product_price * oi.orderItem_quantity) as t2rp1, t.taxRecord_id as t2pk from TaxRecordView t left outer join AddressView a on t.taxRecord_addressId = a.address_id left outer join OrderView o on a.address_customerId = o.order_customerId left outer join OrderItemView oi on o.order_id = oi.orderItem_orderId left outer join ProductView p on oi.orderItem_productId = p.product_id group by t.taxRecord_id ) t2 on t.taxRecord_id = t2pk where t1rp1 > '2020-01-14 12:12:30.0' group by t.taxRecord_rate, t2rp1 order by p0 limit 500;
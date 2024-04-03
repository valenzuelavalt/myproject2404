view: order_items {
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,minute,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

dimension: date_s {
  type: date
  sql: ${created_date} ;;
}

  filter: date_filter {
    type: date
    sql: date_format({% date_start date_filter %}, '%Y-%m-%d');;
  }
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }
  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }
  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }
  dimension: phones {
    type: string
    sql: ${TABLE}.phones ;;
  }
  dimension_group: returned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }
  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }
  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
  measure: counttest {
    type: number
    sql: ${count}*100000 ;;
  }
}

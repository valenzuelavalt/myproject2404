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


  parameter: time_window {
    type: number
    default_value: "1"
  }


  parameter: starting_event {
    type: string
    allowed_value: {
      label: "first_onboarding_tr_created_at"
      value: "first_created"
    }
    #Add other values as needed
    default_value: "first_onboarding_tr_created_at"
  }

  parameter: ending_event {
    type: string
    allowed_value: {
      label: "first_onboarding_tr_approved_at"
      value: "first_approved"
    }
    #Add other values as needed
    default_value: "first_onboarding_tr_approved_at"
  }

  dimension: first_date {
    type: date
    sql:  {% if starting_event._parameter_value == "first_created" %}
    "2019-02-17"
    {% else %}
    "2019-02-17"
    {% endif %};;
    #CHANGE "2019-02-17" TO ${first_onboarding_tr_created_at}
  }
  dimension: end_date {
    type: date
    sql:  {% if starting_event._parameter_value == "first_approved" %}
          "2019-11-25"
          {% else %}
          "2019-11-25"
          {% endif %};;
          #CHANGE "2019-11-25" TO ${first_onboarding_tr_approved at_at}
  }
  measure: one_day_tr_approval_cvr {
    type: number

    sql:  CASE WHEN DATEDIFF(${first_date}, ${end_date}) <= 1
          AND DATEDIFF(LAST_DAY(${first_date}), CURRENT_DATE()) >= 1
          THEN 1
          ELSE 3
          END ;;
    value_format_name: percent_3
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

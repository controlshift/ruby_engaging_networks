module EngagingNetworks
  class ActionCreateAction < ActionModel
    attr_accessor :client_id, :campaign_id, :form_id, :title, :first_name, :last_name, :city, :country, :country_name,  :county, :email, :address_line_1,
                  :address_line_2, :post_code, :state, :mobile_phone, :originating_action, :additional_fields, :result, :raw_response, :opt_in

    validates :client_id,  presence: true, numericality: true
    validates :campaign_id, presence: true, numericality: true
    validates :form_id, presence: true, numericality: true

    validates :country, inclusion: { in: %w(AX AF AL DZ AS AD AO AI AQ AG AR AM AW AU AT AZ BS BH BD BB BY BE BZ BJ BM
                BT BO BA BW BV BR IO BN BG BF BI KH CM CA CV KY CF TD CL CN CX CC CO KM CD CG CK CR CI HR CU CY CZ DK DJ
                DM DO EC EG SV GQ ER EE ET FK FO FJ FI FR GF PF TF GA GM GE DE GH GI GR GL GD GP GU GT GN GW GY HT HM HN
                HK HU IS IN ID IR IQ IE IL IT JM JP JO KZ KE KI KP KR KW KG LA LV LB LS LR LY LI LT LU MO MK MG MW MY MV
                ML MT MH MQ MR MU YT MX FM MD MC MN MS MA MZ MM NA NR NP NL AN NC NZ NI NE NG NU NF MP NO OM PK PW PS PA
                PG PY PE PH PN PL PT PR QA RE RO RU RW SH KN LC PM VC WS SM ST SA SN CS SC SL SG SK SI SB SO ZA GS ES LK
                SD SR SJ SZ SE CH SY TW TJ TZ TH TL TG TK TO TT TN TR TM TC TV UG UA AE GB US UM UY UZ VU VA VE VN VG VI
                WF EH YE ZM ZW) }  # ISO2 country codes

    validates :first_name, :last_name, :email, presence: true

    def to_params
      hsh = {
        'Title' => title,
        'Email address' => email,
        'Email addressConfirm' => email,
        'First name' => first_name,
        'Last name' => last_name,
        'City' => city,
        'Country' => country,
        'County' => county,
        'Country Name' => country_name,
        'Address Line 1' => address_line_1,
        'Address Line 2' => address_line_2,
        'Post Code' => post_code,
        'State' => state,
        'Mobile Phone' => mobile_phone,
        'Originating Action' => originating_action,
        'Opt in' => opt_in_value
      }
      if additional_fields
        hsh.merge(additional_fields)
      else
        hsh
      end
    end

    private

    def opt_in_value
      opt_in ? 'Y' : 'N'
    end
  end
end

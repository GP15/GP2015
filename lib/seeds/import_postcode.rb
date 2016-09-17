module ImportPostcode

  def dump_postcode
    postcode = "#{Rails.root}/lib/seeds/postcodes.txt"

    inputs = File.read(postcode)

    rows = inputs.split("\n")
    rows.each do |row|
      attributes = row.split(",")

      postcode = attributes[0]
      city_name = attributes[1]
      state = attributes[2]

      if Zipcode.find_by_pincode(postcode).blank?
        city = City.find_by_name(city_name)

        if city.blank?
          city = City.create(name: city_name, state: state)
        end

        zipcode = Zipcode.create(pincode: postcode, city: city, active: false)
      end
    end
  end

end




# Creating countries
usa = Country.create!(code: 'US', name: 'United States')
canada = Country.create!(code: 'CA', name: 'Canada')

# Creating regions for USA
Region.create!(name: 'California', country: usa)
Region.create!(name: 'Texas', country: usa)
Region.create!(name: 'Ohio', country: usa)
Region.create!(name: 'Virginia', country: usa)

# Creating regions for Canada
Region.create!(name: 'Ontario', country: canada)
Region.create!(name: 'Quebec', country: canada)
Region.create!(name: 'British Columbia', country: canada)
Region.create!(name: 'Alberta', country: canada)

# Creating a default user
user = User.create!(email: 'juanm.hidalgoav@gmail.com', encrypted_password: '7195c6bbasdds95b86804add8c99f5e587e8f4e64bbd8')

# Creating an API key for the default user
ApiKey.create!(user: user, description: 'Default admin API key')

# Creating a geolocation record
Geolocation.create!(
  ip_or_url: '76.67.111.207',
  country: canada,
  region: Region.find_by(name: 'Ontario'),
  city: 'Kingston',
  latitude: 44.22967,
  longitude: -76.47993,
  api_key: ApiKey.first
)
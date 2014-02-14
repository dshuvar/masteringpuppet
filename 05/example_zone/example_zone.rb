require('ipaddr')

def zone(ip)
  zones = {
    'production' => [IPAddr.new('192.168.122.0/24'),IPAddr.new('192.168.124.0/23')],
    'development' => [IPAddr.new('192.168.123.0/24'),IPAddr.new('192.168.126.0/23')],
    'sandbox' => [IPAddr.new('192.168.128.0/22')]
  }
  for zone in zones.keys do
    for subnet in zones[zone] do
      if subnet.include?(ip)
        return zone
      end
    end
  end
  return 'undef'
end

ip = IPAddr.new(Facter.value('ipaddress'))
Facter.add('example_zone') do
  setcode do zone(ip) end
end

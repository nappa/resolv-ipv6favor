require 'resolv'

#
# =Resolver class that resolves AAAA record first, then A record
#
class IPv6FavorResolv

  def self.each_address(name)
    DefaultResolver.each_address(name)
  end

  def self.getaddresses(name)
    DefaultResolver.getaddresses(name)
  end

  def self.getaddress(name)
    DefaultResolver.getaddress(name)
  end

  def initialize(resolv_conf='/etc/resolv.conf')
    @r = Resolv::DNS.new(resolv_conf)
  end
  DefaultResolver = self.new

  def each_address(name)
    @r.each_resource(name, Resolv::DNS::Resource::IN::AAAA) {|resource| yield resource.address}
    @r.each_resource(name, Resolv::DNS::Resource::IN::A) {|resource| yield resource.address}
  end

  def getaddresses(name)
    res = []
    each_address(name) { |addr| res << addr}
    res
  end

  def getaddress(name)
    getaddresses(name)[0]
  end
end

require 'helper'
require 'pp'

class TestResolvIpv6favor < Test::Unit::TestCase
  should "resolv AAAA first then A" do
    # XXX: I'm looking for better node for this test...
    node = "www.iij.ad.jp"

    assert IPv6FavorResolv.getaddress(node).kind_of?(Resolv::IPv6)
    assert IPv6FavorResolv.getaddresses(node)[-1].kind_of?(Resolv::IPv4)
    assert IPv6FavorResolv.getaddresses(node)[0].kind_of?(Resolv::IPv6)
  end
end

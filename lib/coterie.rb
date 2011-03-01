require "ohm"
require "ohm/contrib"
require "digest"

require "coterie/user"
require "coterie/ohm_extensions"

module Coterie
  VERSION = "0.1"
  SALT = "unguess4ble"
  
  def self.connect
    Ohm.connect
  end
end
require 'base32'
require 'openssl'
require 'securerandom'

module Otp

	class Totp

		attr_accessor :secret, :time_step

		def initialize(secret = nil, time_step = 30)
			@secret = secret.nil? ? generate_secret : secret
			@time_step = time_step
		end

		def get_otp
			code = get_code
		  return (code % 10**6).to_s.rjust(6, '0')
		end

		
		def validate_otp?(otp)
			get_otp == otp.to_s
		end
		
		private
		
		def generate_secret
			Base32.encode(SecureRandom.uuid).tr('=','')
		end
		
		def time_int
			Time.now.to_i / @time_step
		end

		def byte_secret
		  Base32.decode(@secret)
		end

		def int_to_bytestring(int, padding = 8)
		  unless int >= 0
		    raise ArgumentError, '#int_to_bytestring requires a positive number'
		  end

		  result = []
		  until int == 0
		    result << (int & 0xff).chr
		    int >>= 8
		  end
		  return result.reverse.join.rjust(padding, 0.chr)
		end

		def get_code
		  hmac = OpenSSL::HMAC.digest(
		    			OpenSSL::Digest.new('sha1'),
		    			byte_secret,
		    			int_to_bytestring(time_int)
		  			)

		  offset = hmac[-1].ord & 0xf
		  code = (hmac[offset].ord & 0x7f) << 24 |
		         (hmac[offset + 1].ord & 0xff) << 16 |
		         (hmac[offset + 2].ord & 0xff) << 8 |
		         (hmac[offset + 3].ord & 0xff)
		  return code
		end
	end
end
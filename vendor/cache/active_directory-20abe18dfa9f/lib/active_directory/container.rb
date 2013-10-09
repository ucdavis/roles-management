#-- license
#
#  Based on original code by Justin Mecham and James Hunt
#  at http://rubyforge.org/projects/activedirectory
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#++ license

module ActiveDirectory
	#
	# The ActiveDirectory::Container class represents a more malleable way
	# of dealing with LDAP Distinguished Names (dn), like
	# "cn=UserName,ou=Users,dc=example,dc=org".
	#
	# The following two representations of the above dn are identical:
	#
	#   dn = "cn=UserName,ou=Users,dc=example,dc=org"
	#   dn = ActiveDirectory::Container.dc('org').dc('example').ou('Users').cn('UserName').to_s
	#
	class Container
		attr_reader :type
		attr_reader :name
		attr_reader :parent

		def initialize(type, name, node = nil) #:nodoc:
			@type = type
			@name = name
			@node = node
		end

		#
		# Creates a starting OU (Organizational Unit) dn part.
		#
		#   # ou_part = "ou=OrganizationalUnit"
		#   ou_part = ActiveDirectory::Container.ou('OrganizationalUnit').to_s
		#
		def self.ou(name)
			new(:ou, name, nil)
		end

		#
		# Creates a starting DC (Domain Component) dn part.
		#
		#   # dc_part = "dc=net"
		#   dc_part = ActiveDirectory::Container.dc('net').to_s
		#
		def self.dc(name)
			new(:dc, name, nil)
		end

		#
		# Creates a starting CN (Canonical Name) dn part.
		#
		#   # cn_part = "cn=CanonicalName"
		#   cn_part = ActiveDirectory::Container.cn('CanonicalName').to_s
		#
		def self.cn(name)
			new(:cn, name, nil)
		end

		#
		# Appends an OU (Organizational Unit) dn part to another Container.
		#
		#   # ou = "ou=InfoTech,dc=net"
		#   ou = ActiveDirectory::Container.dc("net").ou("InfoTech").to_s
		#
		def ou(name)
			self.class.new(:ou, name, self)
		end

		#
		# Appends a DC (Domain Component) dn part to another Container.
		#
		#   # base = "dc=example,dc=net"
		#   base = ActiveDirectory::Container.dc("net").dc("example").to_s
		#
		def dc(name)
			self.class.new(:dc, name, self)
		end

		#
		# Appends a CN (Canonical Name) dn part to another Container.
		#
		#    # user = "cn=UID,ou=Users"
		#    user = ActiveDirectory::Container.ou("Users").cn("UID")
		#
		def cn(name)
			self.class.new(:cn, name, self)
		end

		#
		# Converts the Container object to its String representation.
		#
		def to_s
			@node ? "#{@type}=#{name},#{@node.to_s}" : "#{@type}=#{name}"
		end

		def ==(other) #:nodoc:
			to_s.downcase == other.to_s.downcase
		end
	end
end

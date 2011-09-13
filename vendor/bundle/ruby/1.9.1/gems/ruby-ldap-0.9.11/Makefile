
SHELL = /bin/sh

#### Start of system configuration section. ####

srcdir = .
topdir = /Users/chmthielen/.rvm/rubies/ruby-1.9.2-p290/include/ruby-1.9.1
hdrdir = /Users/chmthielen/.rvm/rubies/ruby-1.9.2-p290/include/ruby-1.9.1
arch_hdrdir = /Users/chmthielen/.rvm/rubies/ruby-1.9.2-p290/include/ruby-1.9.1/$(arch)
VPATH = $(srcdir):$(arch_hdrdir)/ruby:$(hdrdir)/ruby
prefix = $(DESTDIR)/Users/chmthielen/.rvm/rubies/ruby-1.9.2-p290
rubylibprefix = $(libdir)/$(RUBY_BASE_NAME)
exec_prefix = $(prefix)
vendorhdrdir = $(rubyhdrdir)/vendor_ruby
sitehdrdir = $(rubyhdrdir)/site_ruby
rubyhdrdir = $(includedir)/$(RUBY_BASE_NAME)-$(ruby_version)
vendordir = $(rubylibprefix)/vendor_ruby
sitedir = $(rubylibprefix)/site_ruby
ridir = $(datarootdir)/$(RI_BASE_NAME)
mandir = $(datarootdir)/man
localedir = $(datarootdir)/locale
libdir = $(exec_prefix)/lib
psdir = $(docdir)
pdfdir = $(docdir)
dvidir = $(docdir)
htmldir = $(docdir)
infodir = $(datarootdir)/info
docdir = $(datarootdir)/doc/$(PACKAGE)
oldincludedir = $(DESTDIR)/usr/include
includedir = $(prefix)/include
localstatedir = $(prefix)/var
sharedstatedir = $(prefix)/com
sysconfdir = $(prefix)/etc
datadir = $(datarootdir)
datarootdir = $(prefix)/share
libexecdir = $(exec_prefix)/libexec
sbindir = $(exec_prefix)/sbin
bindir = $(exec_prefix)/bin
rubylibdir = $(rubylibprefix)/$(ruby_version)
archdir = $(rubylibdir)/$(arch)
sitelibdir = $(sitedir)/$(ruby_version)
sitearchdir = $(sitelibdir)/$(sitearch)
vendorlibdir = $(vendordir)/$(ruby_version)
vendorarchdir = $(vendorlibdir)/$(sitearch)

CC = /usr/bin/gcc-4.2
CXX = g++
LIBRUBY = $(LIBRUBY_SO)
LIBRUBY_A = lib$(RUBY_SO_NAME)-static.a
LIBRUBYARG_SHARED = -l$(RUBY_SO_NAME)
LIBRUBYARG_STATIC = -l$(RUBY_SO_NAME)-static
OUTFLAG = -o 
COUTFLAG = -o 

RUBY_EXTCONF_H = 
cflags   =  $(optflags) $(debugflags) $(warnflags)
optflags = -O3
debugflags = -ggdb
warnflags = -Wextra -Wno-unused-parameter -Wno-parentheses -Wpointer-arith -Wwrite-strings -Wno-missing-field-initializers -Wshorten-64-to-32 -Wno-long-long
CFLAGS   = -fno-common $(cflags)  -fno-common -pipe 
INCFLAGS = -I. -I$(arch_hdrdir) -I$(hdrdir)/ruby/backward -I$(hdrdir) -I$(srcdir)
DEFS     = 
CPPFLAGS = -DUSE_OPENLDAP2 -DUSE_OPENLDAP -DLDAP_DEPRECATED -D_REENTRANT -DHAVE_LDAP_H -DHAVE_LBER_H -DHAVE_OPENSSL_SSL_H -DHAVE_OPENSSL_CRYPTO_H -DHAVE_LDAP_INIT -DHAVE_LDAP_SET_OPTION -DHAVE_LDAP_GET_OPTION -DHAVE_LDAP_START_TLS_S -DHAVE_LDAP_MEMFREE -DHAVE_LDAP_PERROR -DHAVE_LDAP_SORT_ENTRIES -DHAVE_LDAP_SASL_BIND_S -DHAVE_LDAP_COMPARE_S -DHAVE_LDAP_ADD_EXT_S -DHAVE_LDAP_COMPARE_EXT_S -DHAVE_LDAP_DELETE_EXT_S -DHAVE_LDAP_MODIFY_EXT_S -DHAVE_LDAP_SEARCH_EXT_S -DHAVE_LDAP_UNBIND_EXT_S -DHAVE_LDAP_SASL_INTERACTIVE_BIND_S -DRUBY_VERSION_CODE=192 -D_XOPEN_SOURCE -D_DARWIN_C_SOURCE $(DEFS) $(cppflags)
CXXFLAGS = $(CFLAGS) $(cxxflags)
ldflags  = -L. -L/usr/local/lib
dldflags = -Wl,-undefined,dynamic_lookup -Wl,-multiply_defined,suppress -Wl,-flat_namespace
ARCH_FLAG = 
DLDFLAGS = $(ldflags) $(dldflags)
LDSHARED = $(CC) -dynamic -bundle
LDSHAREDXX = $(CXX) -dynamic -bundle
AR = ar
EXEEXT = 

RUBY_BASE_NAME = ruby
RUBY_INSTALL_NAME = ruby
RUBY_SO_NAME = ruby.1.9.1
arch = x86_64-darwin11.0.0
sitearch = $(arch)
ruby_version = 1.9.1
ruby = /Users/chmthielen/.rvm/rubies/ruby-1.9.2-p290/bin/ruby
RUBY = $(ruby)
RM = rm -f
RM_RF = $(RUBY) -run -e rm -- -rf
RMDIRS = $(RUBY) -run -e rmdir -- -p
MAKEDIRS = mkdir -p
INSTALL = /usr/bin/install -c
INSTALL_PROG = $(INSTALL) -m 0755
INSTALL_DATA = $(INSTALL) -m 644
COPY = cp

#### End of system configuration section. ####

preload = 

libpath = . $(libdir)
LIBPATH =  -L. -L$(libdir)
DEFFILE = 

CLEANFILES = mkmf.log
DISTCLEANFILES = 
DISTCLEANDIRS = 

extout = 
extout_prefix = 
target_prefix = 
LOCAL_LIBS = 
LIBS = $(LIBRUBYARG_SHARED) -lldap -lldap_r -llber -lresolv -lpthread -lssl -lcrypto  -lpthread -ldl -lobjc 
SRCS = conn.c entry.c ldap.c misc.c mod.c saslconn.c sslconn.c
OBJS = conn.o entry.o ldap.o misc.o mod.o saslconn.o sslconn.o
TARGET = ldap
DLLIB = $(TARGET).bundle
EXTSTATIC = 
STATIC_LIB = 

BINDIR        = $(bindir)
RUBYCOMMONDIR = $(sitedir)$(target_prefix)
RUBYLIBDIR = /Users/chmthielen/Projects/Work/dss-rm/vendor/bundle/ruby/1.9.1/gems/ruby-ldap-0.9.11/lib$(target_prefix)
RUBYARCHDIR = /Users/chmthielen/Projects/Work/dss-rm/vendor/bundle/ruby/1.9.1/gems/ruby-ldap-0.9.11/lib$(target_prefix)
HDRDIR        = $(rubyhdrdir)/ruby$(target_prefix)
ARCHHDRDIR    = $(rubyhdrdir)/$(arch)/ruby$(target_prefix)

TARGET_SO     = $(DLLIB)
CLEANLIBS     = $(TARGET).bundle 
CLEANOBJS     = *.o  *.bak

all:    $(DLLIB)
static: $(STATIC_LIB)
.PHONY: all install static install-so install-rb
.PHONY: clean clean-so clean-rb

clean-rb-default::
clean-rb::
clean-so::
clean: clean-so clean-rb-default clean-rb
		@-$(RM) $(CLEANLIBS) $(CLEANOBJS) $(CLEANFILES)

distclean-rb-default::
distclean-rb::
distclean-so::
distclean: clean distclean-so distclean-rb-default distclean-rb
		@-$(RM) Makefile $(RUBY_EXTCONF_H) conftest.* mkmf.log
		@-$(RM) core ruby$(EXEEXT) *~ $(DISTCLEANFILES)
		@-$(RMDIRS) $(DISTCLEANDIRS)

realclean: distclean
install: install-so install-rb

install-so: $(RUBYARCHDIR)
install-so: $(RUBYARCHDIR)/$(DLLIB)
$(RUBYARCHDIR)/$(DLLIB): $(DLLIB)
	@-$(MAKEDIRS) $(@D)
	$(INSTALL_PROG) $(DLLIB) $(@D)
install-rb: pre-install-rb install-rb-default
install-rb-default: pre-install-rb-default
pre-install-rb: Makefile
pre-install-rb-default: Makefile
pre-install-rb-default: $(RUBYLIBDIR)/ldap
install-rb-default: $(RUBYLIBDIR)/ldap/control.rb
$(RUBYLIBDIR)/ldap/control.rb: $(srcdir)/lib/ldap/control.rb
	@-$(MAKEDIRS) $(@D)
	$(INSTALL_DATA) $(srcdir)/lib/ldap/control.rb $(@D)
install-rb-default: $(RUBYLIBDIR)/ldap/ldif.rb
$(RUBYLIBDIR)/ldap/ldif.rb: $(srcdir)/lib/ldap/ldif.rb
	@-$(MAKEDIRS) $(@D)
	$(INSTALL_DATA) $(srcdir)/lib/ldap/ldif.rb $(@D)
install-rb-default: $(RUBYLIBDIR)/ldap/schema.rb
$(RUBYLIBDIR)/ldap/schema.rb: $(srcdir)/lib/ldap/schema.rb
	@-$(MAKEDIRS) $(@D)
	$(INSTALL_DATA) $(srcdir)/lib/ldap/schema.rb $(@D)
$(RUBYARCHDIR):
	$(MAKEDIRS) $@
$(RUBYLIBDIR)/ldap:
	$(MAKEDIRS) $@

site-install: site-install-so site-install-rb
site-install-so: install-so
site-install-rb: install-rb

.SUFFIXES: .c .m .cc .cxx .cpp .C .o

.cc.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $<

.cxx.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $<

.cpp.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $<

.C.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $<

.c.o:
	$(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) $(COUTFLAG)$@ -c $<

$(DLLIB): $(OBJS) Makefile
	@-$(RM) $(@)
	$(LDSHARED) -o $@ $(OBJS) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)



$(OBJS): $(hdrdir)/ruby.h $(hdrdir)/ruby/defines.h $(arch_hdrdir)/ruby/config.h

test::
	/bin/sh $(srcdir)/test/test.sh ruby newcert; /bin/sh $(srcdir)/test/test.sh ruby openldap2-ssl /usr/libexec/slapd /usr/etc/openldap

testclean: test-clean

test-clean::
	(cd $(srcdir); /bin/sh test/test.sh clean)

reconfig::
	$(RUBY_INSTALL_NAME) $(srcdir)/extconf.rb 

doc:
#	$(RUBY_INSTALL_NAME) -rrdoc/ri/ri_paths -e 'puts RI::Paths::PATH[0]'
	rdoc --ri-site *.c lib/ldap

unit:
	(cd test; $(RUBY_INSTALL_NAME) tc_ldif.rb)

.PHONY:	doc

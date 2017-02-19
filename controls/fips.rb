only_if { os.family == 'redhat' }

control 'fips-01' do
  impact 1.0
  title 'Check prelinking settings'
  desc 'Prelinking should be switched off'

  describe file('/etc/sysconfig/prelink') do
    its(:content) { should match /PRELINKING=no/ }
  end
end

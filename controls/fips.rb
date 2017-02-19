only_if { os.family == 'redhat' }

control 'fips-01' do
  impact 1.0
  title 'Check prelinking settings'
  desc 'Prelinking should be switched off'

  describe file('/etc/sysconfig/prelink') do
    its(:content) { should match /PRELINKING=no/ }
  end
end

control 'fips-02' do
  impact 1.0
  title 'Check packages'

  describe package('dracut-fips') do
    it { should be_installed }
  end
end

control 'fips-03' do
  impact 1.0
  title 'Check kernel params'
  desc 'FIPS mode shoud be enabled'

  describe kernel_parameter('crypto/fips_enabled') do
    its(:value) { should eq 1 }
  end
end

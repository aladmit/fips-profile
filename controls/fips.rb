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

# TODO: create issue on github. can't check modules
control 'fips-04' do
  impact 1.0
  title 'Check crypt modules'
  desc 'System should use specific crypto modules'

  describe kernel_module('fcrypt') do
    it { should be_enabled }
  end

  describe kernel_module('dm_crypt') do
    it { should be_enabled }
  end

  describe kernel_module('crypto_null') do
    it { should be_enabled }
  end

  describe kernel_module('cryptd') do
    it { should be_enabled }
  end

  describe kernel_module('dm_mod') do
    it { should be_enabled }
  end
end

control 'fips-05' do
  impact 1.0
  title 'Check grub settings'
  desc 'Kernel should have fips param and boot part'

  describe grub_conf('/boot/grub2/grub.cfg') do
    its(:kernel) { should include 'fips=1' }
  end

  describe grub_conf('/boot/grub2/grub.cfg') do
    its(:kernel) { should include /boot=/ }
  end
end

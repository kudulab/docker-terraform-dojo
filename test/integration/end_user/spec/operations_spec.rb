require_relative './spec_helper'
require 'English'
require 'open3'

context 'operations' do

  before :all do
    generate_idefiles()
  end

  after :all do
    rm_idefiles()
  end

  context 'when full identity' do
    it 'is correctly initialized; pwd shows /ide/work' do
      cmd = "cd #{test_ide_work} && ide \"pwd && whoami\""

      output, exit_status = run_cmd(cmd)

      expect(output).to include('ide init finished')
      expect(output).to include('/ide/work')
      expect(output).to include('ide')
      expect(output).to include('terraformide')
      expect(output).not_to include('root')
      expect(exit_status).to eq 0
    end
    it 'correct terraform version is installed' do
      cmd = "cd #{test_ide_work} && ide \"terraform --version\""

      output, exit_status = run_cmd(cmd)

      expect(output).to include('Terraform v0.7.3')
      expect(exit_status).to eq 0
    end
    it 'openstack env variables are preserved' do
      # do not show openstack password in logs
      cmd = "cd #{test_ide_work} && ide \"env | grep OS_ | grep -v OS_PASSWORD\""

      output, exit_status = run_cmd(cmd)

      expect(output).to include('OS_USERNAME')
      expect(exit_status).to eq 0
    end
  end
end

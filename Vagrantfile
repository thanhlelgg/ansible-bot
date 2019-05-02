Vagrant.configure("2") do |config|
  config.vm.box = 'vsphere'
  config.vm.box_url = './dummy.box'

  config.vm.provider :vsphere do |vsphere|
    # The host we're going to connect to
    vsphere.host = 'vsphere.ankicore.com'
    vsphere.data_center_name = 'san-francisco'

   # The host for the new VM
    vsphere.compute_resource_name = 'anki-vsphere-copp.ankicore.com'

    # are we cloning from an existing vm?  
    vsphere.clone_from_vm = false

    # The vm we are to clone, full folder path     
    vsphere.template_name = 'LabESXi/ubuntu-14.04.05-vagrant-150g-thin'

    # The name of the new machine
    vsphere.name = 'bots-vm001'

    # vSphere login
    vsphere.user = 'jliptak@anki.com'
                         

    # If you don't have the AnkiCore SSL root loaded, set this to 'true'
    vsphere.insecure = true
  end

  #if you feel the need to change the playbook executed, do so here

  config.vm.provision "ansible" do |ansible|
    #ansible.verbose = "v" #here is a verbose call for when you need it
    ansible.playbook = "site.yml"
  end
end

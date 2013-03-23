require 'vagrant'

module VagrantPlugins
  module WINRM
    module Errors

      class VagrantWINRMError < Vagrant::Errors::VagrantError
        error_namespace("vagrant_winrm.errors")
      end

      class WinRMPortNotDetected < VagrantWINRMError
        #status_code(550)
        error_key(:winrm_port_not_detected)
      end
      
      class WinRMInvalidShell < VagrantWINRMError
        #status_code(551)
        error_key(:winrm_invalid_shell)
      end
      class WinRMTransferError < VagrantWINRMError
        #status_code(552)
        error_key(:winrm_upload_error)
      end
      class WinRMTimeout < VagrantWINRMError
        #status_code(553)
        error_key(:winrm_timeout)
      end
      
    end
  end
end

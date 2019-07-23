require 'bootstrap/alert'

module BootstrapHelper
  def bs_flash(options = {})
    Bootstrap::Alert.new(options, self).render
  end
end

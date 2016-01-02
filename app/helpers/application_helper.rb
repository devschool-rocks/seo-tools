require 'addressable'

module ApplicationHelper

  def domain_only(url)
    Addressable::URI.parse(url).host
  end
end

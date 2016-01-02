class DomainsController < ApplicationController
  def index
    @domains = Domain.all
  end

  def create
    existing = Domain.all.map(&:value)
    to_add   = params[:domains].
                 split("\n").
                 map(&:strip).uniq
    to_add.each do |d|
      domain = strip_protocol(d)
      next if existing.include?(domain)
      Domain.create value: domain
    end
    redirect_to domains_path
  end

  def destroy
    domain = Domain.find(params[:id])
    domain.destroy
    redirect_to domains_path
  end

private

  def strip_protocol(url)
    url.downcase.gsub("http://","").
      gsub("https://","").
      strip
  end

end

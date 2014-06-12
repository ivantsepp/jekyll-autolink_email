require 'jekyll'
require 'rinku'

module Jekyll
  class AutolinkEmail < Jekyll::Generator

    safe true

    def initialize(config)
      config['autolink_email'] ||= {}
    end

    def generate(site)
      @site = site
      site.pages.each { |page| autolinkify page if page.html?}
      site.posts.each { |page| autolinkify page }
    end

    private

    def autolinkify(page)
      page.content = Rinku.auto_link(page.content, :email_addresses, link_attr, skip_tags)
    end

    def link_attr
      @link_attr ||= @site.config['autolink_email']['link_attr']
    end

    def skip_tags
      @skip_tags ||= Array(@site.config['autolink_email']['skip_tags'])
    end
  end
end

require 'helper'

class Jekyll::AutolinkEmailTest < Minitest::Test
  context 'AutolinkEmail' do

    setup do
      @site = Jekyll::Site.new(Jekyll::Configuration::DEFAULTS)
      @autolink_email = Jekyll::AutolinkEmail.new(@site.config)
      @page = Jekyll::Page.new(@site, File.expand_path('../../', __FILE__), '', 'README.md')
      @page.instance_variable_set(:@content, '<div>ivan.tse1@gmail.com</div>')
      @site.pages << @page
      @email_link = '<div><a href="mailto:ivan.tse1@gmail.com">ivan.tse1@gmail.com</a></div>'
    end

    should 'replace email with link' do
      @autolink_email.instance_variable_set(:@site, @site)
      @autolink_email.send(:autolinkify, @page)
      assert_equal @email_link, @page.content
    end

    should 'replace page content on generate' do
      @autolink_email.generate(@site)
      assert_equal @email_link, @page.content
    end

    should 'replace page content on site#generate' do
      @site.generators = Array(@autolink_email)
      @site.generate
      assert_equal @email_link, @page.content
    end

    should 'pull link_attr from config' do
      @site.config['autolink_email']['link_attr'] = 'class="ivan"'
      @autolink_email.generate(@site)
      assert @page.content.include?('class="ivan"')
    end

    should 'pull skip_tags from config' do
      @site.config['autolink_email']['skip_tags'] = 'div'
      @autolink_email.generate(@site)
      assert_equal '<div>ivan.tse1@gmail.com</div>', @page.content
    end

    should 'not replace email with link if page is not html' do
      @page = Jekyll::Page.new(@site, File.expand_path('../../', __FILE__), '', 'LICENSE.txt')
      @page.instance_variable_set(:@content, '<div>ivan.tse1@gmail.com</div>')
      @site.pages << @page
      @autolink_email.generate(@site)
      assert_equal '<div>ivan.tse1@gmail.com</div>', @page.content
    end

    should 'escape email' do
      @site.config['autolink_email']['escape'] = true
      escaped_email_link = '<div><a href="mailto:ivan.tse1%40gmail.com">ivan&#046;tse1&#064;gmail&#046;com</a></div>'
      @autolink_email.instance_variable_set(:@site, @site)
      @autolink_email.send(:autolinkify, @page)
      assert_equal escaped_email_link, @page.content
    end
  end
end

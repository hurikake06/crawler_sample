# カテゴリーのDB更新
def refresh_href_category
  host = "https://hotlines.shop/"
  all_category = Nokogiri::HTML(open(host + "category/"), nil, "utf-8")
  p '----------'

  all_category.xpath("//ul[@class='category-list list-unstyled']/li").each do |li|
    item_parent = li.xpath("p[@class='child-category']").css("a").first
    pp "href:#{item_parent["href"]},name:#{item_parent.content}"

    Hotline::Category.transaction do
      parent = nil
      if(Hotline::Category.exists?(href: item_parent["href"]))
        parent = Hotline::Category.find_by(href: item_parent["href"])
      else
        parent = Hotline::Category.create!(href: item_parent["href"], name: item_parent.content)
      end
      li.xpath("ul[@class='type-list']/li/a").each do |item_child|
        unless(Hotline::Category.exists?(href: item_child["href"]))
          Hotline::Category.create!(href: item_child["href"], name: item_child.content, parent_id: parent.id)
        end
      end
    end
  end
end

# サービスのDB（uri）更新
def refresh_href_service
  host = "https://hotlines.shop/"
  Hotline::Category.all.each do |category|
    next unless category.children.empty?
    url = URI.join(host, category.href)
    pp '----------'
    pp "category:#{category.name}"

    max = 1
    category_page = Nokogiri::HTML(open(url), nil, "utf-8")
    if category_page.css("ul.pagination-list").present?
      max = category_page.css("ul.pagination-list > li > a").last["href"]
      max&.slice!("././?page=")
      max = max.to_i
    end

    count1 = 0
    count2 = 0
    1.upto(max) do |page_num|
      url.query = {page: page_num}.to_param
      page = Nokogiri::HTML(open(url), nil, "utf-8")
      page.css('.link_box > a').each do |service_link|
        count1 += 1
        href = service_link["href"].split("/").last + "/"
        # pp "#{(count1 + count2).to_s}:#{service_link["href"]}"
        Hotline::Service.transaction do
          unless (Hotline::Service.exists?(href: href))
            Hotline::Service.create!(href: href, category_id: category.id)
          end
        end
      end

      # 準備中のサービス
      page.css('.nolink_box').each do |service_link|
        count2 += 1
        # pp (count1 + count2).to_s + ":" + "nolink"
      end
    end

    pp "active:#{count1}"
    pp "unactive:#{count2}"
    pp "all:#{count1 + count2}"
  end
end

# DBのサービス（uri）からデータ取得
# 主な取得データ"[\"店長\",\"所在地\",\"営業時間\",\"定 休 日\",\"対応地域\",\"電話番号\",\"WEB\"]"
def update_service service:
  host = "https://hotlines.shop/"
  url = URI.join(host, service.category.href).to_s
  url = URI.join(url, service.href).to_s
  p url
  service_page = Nokogiri::HTML(open(url), nil, "utf-8")
  store = service_page.xpath("//div[@class='store-details-wrap']")
  service_map = {}
  count = 0
  store.xpath(".//tr").each do |tr|
    count += 1
    th = '', td = ''
    if(count == 1)
      th = '店長'
      td = tr.xpath(".//td").first.xpath(".//p").first.content.split("：").last
    else
      th = tr.css("th").first.content.gsub(/[[:cntrl:]]/,'')
      td = tr.css("td").first.content.gsub(/[[:cntrl:]]/,'')
    end
    service_map[th] = td
  end
  Hotline::Service.transaction do
    service.value = service_map.to_json
    service.save
  end
  return service_map
  # pp service.xpath("//div[@class='shoptable']").first.css("p").inner_html
end

namespace :hotline do
  desc "hotlineのDB全体更新"
  task :all_update => :environment do
    refresh_href_category
    refresh_href_service
    pp "------------"
    count = 0
    Hotline::Service.all.each do |service|
      count += 1
      p count
      update_service service: service
    end
  end

  desc "サービスidからjsonデータ更新"
  task :service_update, [:service_id] => :environment do |task, args|
    print update_service service: Hotline::Service.find(args[:service_id])
  end
end

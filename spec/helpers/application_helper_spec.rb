require "rails_helper"

describe ApplicationHelper do
  describe "#nav_item" do
    it "renders a div with a nav-item class" do
      item = nav_item { "hello" }
      expect(item).to match(/hello/)
      expect(item).to match(/div/)
      expect(item).to match(/nav-item/)
    end

    it "can render a different tag" do
      item = nav_item :section { "hello" }
      expect(item).not_to match(/div/)
      expect(item).to match(/section/)
      expect(item).to match(/hello/)
    end

    it "can take additional options" do
      item = nav_item(:a, href: "/") { "hello" }
      expect(item).to match(/hello/)
      expect(item).to match(/<a.*>/)
      expect(item).to match(/href="\/"/)
    end

    it "can handle additional classes" do
      item = nav_item(:div, class: "is-brand") { "goodbye" }
      expect(item).to match(/goodbye/)
      expect(item).to match(/nav-item/)
      expect(item).to match(/is-brand/)
    end
  end
end

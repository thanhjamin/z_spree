require 'spec_helper'

describe Spree::Admin::PromotionsController do
  stub_authorization!

  let!(:promotion1) { create(:promotion, name: "name1", code: "code1", path: "path1") }
  let!(:promotion2) { create(:promotion, name: "name2", code: "code2", path: "path2") }

  context "#index" do

    it "succeeds" do
      spree_get :index
      expect(assigns[:promotions]).to match_array [promotion2, promotion1]
    end

    context "search" do
      it "pages results" do
        spree_get :index, per_page: '1'
        expect(assigns[:promotions]).to eq [promotion2]
      end

      it "filters by name" do
        spree_get :index, q: {name_cont: promotion1.name}
        expect(assigns[:promotions].map(&:id)).to eq [promotion1.id]
      end

      it "filters by code" do
        spree_get :index, q: {code_cont: promotion1.code}
        expect(assigns[:promotions].map(&:id)).to eq [promotion1.id]
      end

      it "filters by path" do
        spree_get :index, q: {path_cont: promotion1.path}
        expect(assigns[:promotions].map(&:id)).to eq [promotion1.id]
      end
    end
  end

end

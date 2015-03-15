describe Bumbleworks::Api::EntitiesController do
  describe "#types" do
    it "returns entity types" do
      get "/entities"
      expect(last_response.body).to eq(
        json_presentation_of(Bumbleworks.entity_classes)
      )
    end
  end

  describe "#index" do
    it "returns all existing instances of a given entity type" do
      foo, bar, baz = Widget.new('foo'),
                      Widget.new('bar'),
                      WidgetyFidget.new('baz')
      get "/entities/widget"
      expect(last_response.body).to eq(
        json_presentation_of([foo, bar], :as => 'Entity')
      )
    end
  end

  describe "#show" do
    it "returns requested instance" do
      foo = Widget.new(130)
      get "/entities/widget/130"
      expect(last_response.body).to eq(
        json_presentation_of(foo, :as => 'Entity')
      )
    end
  end
end
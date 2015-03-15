module ApiHelper
  include Rack::Test::Methods

  def app
    Bumbleworks::Api::Application
  end

  def json_presentation_of(object, as: nil)
    as ||= infer_class_name(object)
    presentation_class = Rory::Support.constantize("Bumbleworks::Api::#{as}Presenter")
    presented = presentation_class.present(object)
    Rory::Support.encode_as_json(presented)
  end

  def infer_class_name(object)
    reference_object = object.is_a?(Array) ? object.first : object
    if reference_object.is_a?(Class)
      "EntityClass"
    else
      reference_object.class.name
    end
  end
end

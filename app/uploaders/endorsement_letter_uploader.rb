class EndorsementLetterUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  #storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{ENV['DOCUMENT_PATH']}/documents/nomination/#{mounted_as}/#{model.id}"
  end

  #def cache_dir
  #  "documents/nomination/#{mounted_as}/#{model.id}"
  #end

  def url
    begin
    "/documents/nomination/#{mounted_as}/#{model.id}/#{File.basename(path)}"
    rescue
    end
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

end

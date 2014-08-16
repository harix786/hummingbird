# == Schema Information
#
# Table name: videos
#
#  id                :integer          not null, primary key
#  url               :string(255)      not null
#  embed_data        :string(255)      not null
#  available_regions :string(255)      default(["US"]), is an Array
#  episode_id        :integer
#  streamer_id       :integer
#  created_at        :datetime
#  updated_at        :datetime
#  sub_lang          :string(255)
#  dub_lang          :string(255)
#

class Video < ActiveRecord::Base
  belongs_to :episode
  belongs_to :streamer

  def self.create_or_update_from_hash(hash)
    video = Video.where(
      episode: hash[:episode],
      streamer: hash[:streamer],
      sub_lang: hash[:sub_lang],
      dub_lang: hash[:dub_lang]
    ).first_or_create
    video.assign_attributes({
      embed_data: hash[:embed_data],
      available_regions: hash[:available_regions]
    })
    video.save!
  end
end

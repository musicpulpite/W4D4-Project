# == Schema Information
#
# Table name: albums
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  year       :integer          not null
#  live_album :boolean
#  band_id    :integer          not null
#

class Album < ApplicationRecord
  validates :title, :year, :live_album, :band_id, presence: true
  validates_uniqueness_of :title, :scope => [:band_id]

  belongs_to :band,
    foreign_key: :band_id,
    primary_key: :id,
    class_name: :Band,
    dependent: :destroy

    
end

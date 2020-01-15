# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :client
  belongs_to :available_frame

  validates :client, presence: true
  validates :available_frame, presence: true, uniqueness: true
  validates :client_id, uniqueness: { scope: [:available_frame_id] }
end

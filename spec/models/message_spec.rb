require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do
    before do
      @message = FactoryBot.build(:message)
      @message.image = fixture_file_upload('public/images/test_image.png')
    end

    it 'contentとimageが存在していれば保存できる' do
      expect(@message).to be_valid
    end
    it 'contentが存在していれば保存できる' do
      @message.image = nil
      expect(@message).to be_valid
    end
    it 'imageが存在していれば保存できる' do
      @message.content = nil
      expect(@message).to be_valid
    end
    it 'contentとimageが空では保存できない' do
      @message.content = nil
      @message.image = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Contentを入力してください")
    end
    it 'roomが紐づいていないと保存できない' do
      @message.room = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Roomを入力してください")
    end
    it 'userが紐づいていないと保存できなi' do
      @message.user = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Userを入力してください")
    end

  end
end

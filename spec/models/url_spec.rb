describe Url, type: :model do

  describe 'TurboStream' do
    context 'when new record is saved' do
      let(:url) { build(:url, url: 'https://www.abc.com', title: 'This is a test url')}

      it 'will fire off an ActionCable blast' do
        expect { url.save }.to broadcast_to('urls')
      end
    end
  end
end

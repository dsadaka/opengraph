RSpec.describe UrlsController, type: :controller do
  let(:url1) { create(:url)}

  describe 'GET #index' do
    let(:do_call) { get :index }

    before do
      url1.reload
      do_call
    end

    context 'without render views' do
      it 'assigns @urls to contents of urls table' do
        urls = assigns(:urls)
        expect(urls.first.url).to eq(url1.url)
        expect(assigns(:url).id).to be_nil
      end
    end

    context 'with render_views' do
      render_views

      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end

      it "has a heading starting with Preview" do
        get :index
        expect(response.body).to match /<h2 .*Preview/im
      end
    end
  end

  describe 'POST #create' do
    let(:url1_url) { url }

    context 'when url passed already exists' do
      let(:url) { url1.url }
      let(:do_call) { post :create, params: { url: { url: url } } }

      it 'does not add a record to urls table' do
        url1.reload
        expect { do_call }.not_to change { Url.count }
      end
    end

    context 'when url passed does not exists' do
      render_views

      let(:url) { Faker::Internet.url }
      let(:do_call) { post :create, params: { url: { url: url } } }

      before :each do
        url1.reload
      end

      it 'enqueues FetchOGJob' do
        expect { do_call }.to have_enqueued_job(FetchOgJob).exactly(:once)
      end
    end
  end
end

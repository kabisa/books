require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'form' do
  before do
    travel_to(Date.parse('2004-12-31')) do
      render partial: 'books/form', locals: { book: book }
    end
  end

  let(:book) { build :book }

  describe 'SimpleForm components' do
    describe 'dropzone' do
      describe 'container' do
        it 'renders a container' do
          expect(rendered).to have_css('.form-group .dropzone-container')
        end

        it 'has some bootstrap classes' do
          expect(rendered).to have_css('.dropzone-container.img-thumbnail')
        end
      end

      describe 'overlay' do
        it 'renders an overlay' do
          expect(rendered).to have_css('.dropzone-container .dropzone-overlay')
        end

        it 'has some bootstrap classes' do
          expect(rendered).to have_css('.dropzone-overlay.d-flex.justify-content-center.align-items-center')
        end

        it 'has an `add` button' do
          expect(rendered).to have_css('.dropzone-overlay a.btn-float.btn.btn-sm.shadow-none.dropzone-action.text-light')
          expect(rendered).to have_css('.dropzone-overlay a i.material-icons', text: 'add_photo_alternate')
        end

        it 'has an `remove` button' do
          expect(rendered).to have_css('.dropzone-overlay a.btn-float.btn.btn-sm.shadow-none.dropzone-action.text-light.ml-3')
          expect(rendered).to have_css('.dropzone-overlay a i.material-icons', text: 'close')
        end

        it 'has a backdrop' do
          expect(rendered).to have_css('.dropzone-overlay .dropzone-backdrop')
        end
      end

      it 'has an image' do
        expect(rendered).to have_css('.dropzone-container img.img-fluid.w-100')
      end

      it 'has a file input' do
        expect(rendered).to have_css('.dropzone-container input[accept="image/*"][type="file"][name="book[cover]"]')
      end

      it 'has a remove field' do
        expect(rendered).to have_css('.dropzone-container input[type="hidden"][name="book[remove_cover]"]', visible: false)
      end

      it 'has a cache field' do
        expect(rendered).to have_css('.dropzone-container input[type="hidden"][name="book[cover_cache]"]', visible: false)
      end

      describe 'Stimulus' do
        subject { rendered }

        it { is_expected.to have_css('.dropzone-container[data-controller="dropzone"]') }
        it { is_expected.to have_css('.dropzone-overlay a[data-action="dragover->dropzone#acceptDrag drop->dropzone#noop dropzone#browse"]', text: 'add_photo_alternate') }
        it { is_expected.to have_css('.dropzone-overlay a[data-action="dragover->dropzone#acceptDrag drop->dropzone#noop dropzone#removeImage"][data-target="dropzone.removeButton"]', text: 'close') }
        it { is_expected.to have_css('.dropzone-container img[data-target="dropzone.previewImage"]') }
        it { is_expected.to have_css('.dropzone-container input[type="file"][data-target="dropzone.fileInput"][data-action="dropzone#handleImage"]') }
        it { is_expected.to have_css('.dropzone-container input[type="hidden"][data-target="dropzone.removeImage"]', visible: false) }
      end
    end

    describe 'datepicker' do
      it 'renders a text input' do
        expect(rendered).to have_css('.datepicker.form-group.book_published_on .textfield-box input.form-control.string')
      end

      it 'has a placeholder' do
        expect(rendered).to have_css('.book_published_on input[placeholder]')
      end
      it 'transforms the max_date to a default formatted string' do
        expect(rendered).to have_css('.book_published_on input[data-max="2005-06-30"]')
      end

      it 'sets some default data attributes' do
        expect(rendered).to have_css('.book_published_on input[data-format="yyyy-mm-dd"]')
        expect(rendered).to have_css('.book_published_on input[data-controller="datepicker"]')
      end

    end
  end
end

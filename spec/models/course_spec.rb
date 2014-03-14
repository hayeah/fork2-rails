require "spec_helper"

describe Course do
end

describe Course::Loader do
  let(:course) {
    Course.create(:short_id => "test-course", :git_url => EXAMPLE_COURSE_PATH.to_s)
  }

  let(:loader) {
    course.loader(EXAMPLE_COURSE_PATH)
  }

  describe "#lessons_to_delete" do
    before {
      @unknown_lesson_1 = course.lessons.create(:short_id => "unknown-lesson-1")
      @unknown_lesson_2 = course.lessons.create(:short_id => "unknown-lesson-2")
      @known_lesson = course.lessons.create(:short_id => "the-first-lesson")
    }

    let(:lessons_to_delete) {
      loader.lessons_to_delete
    }

    it "returns lessons that are no longer in course repo" do
      expect(lessons_to_delete).to include(@unknown_lesson_1)
      expect(lessons_to_delete).to include(@unknown_lesson_2)
    end

    it "doesn't return lesson still in course repo" do
      expect(lessons_to_delete).to_not include(@known_lesson)
    end
  end

  describe "#flag_deleted_lessons" do
    before {
      @unknown_lesson_1 = course.lessons.create(:short_id => "unknown-lesson-1")
      @unknown_lesson_2 = course.lessons.create(:short_id => "unknown-lesson-2")
      @known_lesson = course.lessons.create(:short_id => "the-first-lesson")
      loader.flag_deleted_lessons
    }

    it "flags lessons that are no longer in course repo as deleted" do
      @unknown_lesson_1.reload
      expect(@unknown_lesson_1).to be_deleted
      @unknown_lesson_2.reload
      expect(@unknown_lesson_2).to be_deleted
      @known_lesson.reload
      expect(@known_lesson).to_not be_deleted
    end
  end

  describe "#update_lessons" do
    let(:repo_lesson) {
      double({
        :short_id => "the-first-lesson",
        :content => "content",
        :intro => "intro",
        :title => "title",
        :commit => "commit",
        :position => 0
      })
    }

    before {
      allow(loader).to receive(:repo_lessons) { [repo_lesson] }
    }

    context "create a new lesson" do
      before {
        loader.update_lessons
        @lesson = Lesson.find_by :short_id => repo_lesson.short_id
      }

      it "creates a new lesson" do
        expect(@lesson).to be_a(Lesson)
        expect(@lesson).to_not be_deleted
      end

      it "sets lesson attributes" do
        expect(@lesson.content).to eq(repo_lesson.content)
        expect(@lesson.intro).to eq(repo_lesson.intro)
        expect(@lesson.title).to eq(repo_lesson.title)
        expect(@lesson.commit).to eq(repo_lesson.commit)
      end
    end

    context "updating an existing lesson" do
      before {
        @lesson = course.lessons.create(:short_id => "the-first-lesson", :deleted => true)
        loader.update_lessons
        @lesson.reload
      }

      it "sets deleted to false" do
        expect(@lesson).to_not be_deleted
      end

      it "sets lesson attributes" do
        %w(position content intro title commit).each do |property|
          expect(@lesson.send(property)).to eq(repo_lesson.send(property))
        end
      end
    end
  end
end
require "spec_helper"

describe CohortUser do
  let(:course) {
    create(:course_with_lessons,:lessons_count => 1)
  }

  let(:cohort) {
    create(:cohort_with_users,:course => course,:users_count => 1)
  }

  let(:lesson) {
    course.lessons.first
  }

  let(:cohort_user) {
    cohort.cohort_users.first
  }

  let(:checkin_attrs) {
    {
      :time_spent => 1,
      :difficulty => 3,
      :feedback => "coolz!"
    }
  }

  context "#checkin" do
    let(:checkin) do
      cohort_user.checkin(lesson,checkin_attrs)
    end

    it "creates a valid checkin" do
      expect(checkin).to be_valid
      expect(checkin).to be_a(Checkin)
    end

    it "should fail to checkin the same lesson twice" do
      checkin = cohort_user.checkin(lesson,checkin_attrs)
      checkin2 = cohort_user.checkin(lesson,checkin_attrs)
      expect(checkin).to be_valid
      expect(checkin2).to_not be_valid
    end
  end

  context "lesson progress" do
    let(:course) {
      create(:course_with_lessons,:lessons_count => 3)
    }

    let(:lessons) {
      course.lessons
    }

    let(:cohort) {
      create(:cohort_with_users,{
        :course => course,
        :schedule => {
          "1" => lessons[0].short_id,
          "2" => lessons[1].short_id,
          "3" => lessons[2].short_id,
        },
        :users_count => 1
      })
    }

    let(:checkin) do
      cohort_user.checkin(lessons[0],checkin_attrs)
    end

    before {
      checkin
    }

    it "has two unfinished_lessons" do
      expect(cohort_user.unfinished_lessons).to include(*%w(2 3))
    end

    it "has lesson-2 as the next lesson" do
      expect(cohort_user.next_unfinished_lesson).to eq(lessons[1])
    end

  end
end
require "spec_helper"

describe CohortUser do
  context "#checkin" do
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
end
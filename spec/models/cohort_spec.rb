require "spec_helper"

describe Cohort do
  describe "#add_users_by_github_ids" do
    before {
      user
    }

    let(:user) {
      create(:user,:github_id => "user1")
    }

    let(:cohort) {
      create(:cohort)
    }

    def add(id)
      cohort.add_users_by_github_id(id)
    end

    it "raises error if a github id doesn't have a corresponding user" do
      expect { add("unknown_github_id") }.to raise_error(ActiveRecord::RecordNotFound)
    end

    context "adding user not in cohort" do
      let(:cohort_user) {
        add("user1")
      }

      it "creates a cohort user" do
        expect {
          cohort_user
        }.to change {
          CohortUser.count
        }.by(1)

        expect(cohort_user).to be_persisted
        expect(cohort_user).to be_a(CohortUser)
      end
    end

    context "adding user already in cohort" do
      before {
        add("user1")
      }

      it "does not create a new cohort user" do
        expect {
          add("user1")
        }.to_not change {
          CohortUser.count
        }
      end
    end
  end

  describe Cohort::ScheduleValidator do
    let(:cohort) {
      build(:cohort,:schedule => {"1" => "lesson-1", "2" => "lesson-2"})
    }

    let(:errors) {
      cohort.errors[:schedule]
    }

    context "with lessons that don't exist" do
      it "adds an error for each lesson that doesn't exist" do
        expect(cohort).to_not be_valid
        expect(errors).to have(2).items
      end
    end

    context "with lessons that exist" do
      let(:course) {
        create(:course_with_lessons)
      }

      let(:lessons) {
        course.lessons
      }

      context "adding duplicate lessons" do
        let(:cohort) {
          build(:cohort,:course => course, :schedule => {"1" => lessons[0].short_id, "2" => lessons[0].short_id})
        }

        it "is invalid" do
          expect(cohort).to_not be_valid
        end
      end

      context "adding lessons with non-numerical days" do
        let(:cohort) {
          build(:cohort,:course => course, :schedule => {"day-1" => lessons[0].short_id, "day-2" => lessons[1].short_id})
        }

        it "is invalid" do
          expect(cohort).to_not be_valid
        end
      end

      context "valid schedule" do
        let(:cohort) {
          build(:cohort,:course => course, :schedule => {"1" => lessons[0].short_id, "2" => lessons[1].short_id})
        }

        it "is valid" do
          expect(cohort).to be_valid
        end
      end

      # it "is valid" do
      #   errors
      # end
    end
  end

  describe "#scheduled_lessons" do
    let(:course) {
      create(:course_with_lessons)
    }

    let(:lessons) {
      course.lessons
    }

    let(:cohort) {
      create(:cohort,:course => course, :schedule => {"2" => lessons[1].short_id, "1" => lessons[0].short_id})
    }

    it "sorts the keys in the same order as scheduled_days" do
      expect(cohort.scheduled_days).to eq(%w(1 2))
      expect(cohort.scheduled_lessons.keys).to eq(cohort.scheduled_days)
    end
  end
end
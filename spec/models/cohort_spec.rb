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
end
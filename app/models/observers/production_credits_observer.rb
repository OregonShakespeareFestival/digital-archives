module Observers
  class ProductionCreditsObserver < ActiveRecord::Observer
    def after_commit(record)
      return if new_record?(record)
      return unless has_relevant_changes?(record)

      queue_jobs_for(record)
    end

    private

    def queue_jobs_for(record)
      queue_update_job_for(record)
    end

    def queue_update_job_for(record)
      Sufia.queue.push(new_update_job(record))
    end

    def new_record?(record)
      record.previous_changes.key?(:id)
    end

    def has_relevant_changes?(record)
      attributes_to_watch.any? { |attribute| record.previous_changes.key?(attribute) }
    end

    def new_update_job(_record)
      fail NotImplementedError, "Subclasses must implement :new_update_job"
    end

    def attributes_to_watch
      fail NotImplementedError, "Subclasses must implement :attributes_to_watch"
    end
  end
end

#encoding: utf-8
module CommandExec

  #detect errors
  class ErrorDetector

    def check_for(type,*args)
      case type 
      when :contains
      when :contains_not
      end

    end

  end
end
#        if @error_detection_on.include?(:return_code)
#          if not @error_indicators[:allowed_return_code].include? process.return_code or 
#                 @error_indicators[:forbidden_return_code].include? process.return_code
#
#            @logger.debug "Error detection on return code found an error"
#            process.status = :failed 
#            process.reason_for_failure = :return_code
#          end
#        end
#
#        if @error_detection_on.include?(:stderr) and not process.status == :failed
#          if error_occured?( @error_indicators[:forbidden_words_in_stderr], @error_indicators[:allowed_words_in_stderr], process.stderr)
#            @logger.debug "Error detection on stderr found an error"
#            process.status = :failed 
#            process.reason_for_failure = :stderr
#          end
#        end
#
#        if @error_detection_on.include?(:stdout) and not process.status == :failed
#          if error_occured?( @error_indicators[:forbidden_words_in_stdout], @error_indicators[:allowed_words_in_stdout], process.stdout)
#            @logger.debug "Error detection on stdout found an error"
#            process.status = :failed 
#            process.reason_for_failure = :stdout
#          end
#        end
#
#        if @error_detection_on.include?(:log_file) and not process.status == :failed
#          if error_occured?( @error_indicators[:forbidden_words_in_log_file], @error_indicators[:allowed_words_in_log_file], process.log_file)
#            @logger.debug "Error detection on log file found an error"
#            process.status = :failed 
#            process.reason_for_failure = :log_file
#          end
#        end

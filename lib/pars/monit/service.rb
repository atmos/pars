module Pars
  module Monit
    class Service
      attr_reader :pid, :status, :name, :memory, :monitor_type, :pending_action
      attr_reader :cpu, :group, :load, :collected, :children, :ppid
      
      def initialize(data)
        @pid    = data['pid'].first.to_i rescue -1
        @name   = data['name'].first rescue "Monit is fucked on this box :\\"
        @status = data['status'].first.to_i rescue 1
        @ppid   = data['ppid'].first.to_i rescue 1
        @group  = data['group'].first rescue nil
        
        @memory = (data['memory']||[]).inject({}) do |sum,part|
          part.each do |k,v|
            sum[k.to_sym] = v.first
          end
          sum
        end
        @cpu   = (data['cpu']||[]).inject({}) do |sum,part|
          part.each do |k,v|
            sum[k.to_sym] = v.first
          end
          sum
        end
        @load  = (data['load']||[]).inject({}) do |sum,part|
          part.each do |k,v|
            sum[k.to_sym] = v.first
          end
          sum
        end

        @monitored      = data['monitor'].first.to_i == 1 ? true : false rescue false
        @monitor_type   = data['monitor'].first.to_i rescue 0
        @pending_action = data['pendingaction'].first.to_i rescue 0
        @collected      = Time.at(data['collected'].first.to_i) rescue nil
        @children       = data['children'].first.to_i rescue 0
      end

      def monitored?
        @monitored
      end
    end
  end
end
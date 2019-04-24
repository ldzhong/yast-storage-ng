# encoding: utf-8

# Copyright (c) [2019] SUSE LLC
#
# All Rights Reserved.
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of version 2 of the GNU General Public License as published
# by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, contact SUSE LLC.
#
# To contact SUSE LLC about this file by physical or electronic mail, you may
# find current contact information at www.suse.com.

require "yast"
require "yast/i18n"
require "abstract_method"

Yast.import "HTML"

module Y2Partitioner
  module Widgets
    module DescriptionSection
      # Description section to include in the description of a device
      #
      # A description section is composed by several entries, and each entry might have a
      # help field associated to it.
      #
      # A device description (see {DeviceDescription}) is composed by several description
      # sections.
      class Base
        include Yast::I18n

        # Constructor
        #
        # @param device [Y2Storage::Device]
        def initialize(device)
          @device = device
        end

        # Richtext filled with the data of each section entry
        #
        # @return [String]
        def value
          value = Yast::HTML.Heading(title)
          value << Yast::HTML.List(data)
        end

        # Fields to show in help
        #
        # The device description (see {DeviceDescription#help}) shows the help for the entries
        # of each section.
        #
        # @return [Array<Symbol>]
        def help_fields
          entries_help
        end

      private

        # @return [Y2Storage::Device]
        attr_reader :device

        # @!method entries
        #
        #   Entries to include in the section
        #
        #   It returns a list of hashes, where each hash has two keys: :value and :help.
        #   The :value key contains the name of the method that generates the value of the
        #   entry. And the :help key indicates the help field for such entry.
        #
        #   @example
        #
        #     section.entries #=> [{ value: :device_name, help: :name }, { value: :device_size }]
        #
        #   The above section is composed by two entries. The value of the first one is generated by the
        #   method :device_name and it uses the help field :name. And for the second entry, its value is
        #   generated by calling to :device_size method. In this case there is no help field for the
        #   entry.
        #
        #   @return [Array<Hash>]
        abstract_method :entries

        # @!method title
        #
        #   Section title
        #
        #   @return [String]
        abstract_method :title

        # Data generated by calling the value method of each entry
        #
        # @return [Array<String>]
        def data
          entries_value.map { |v| send(v) }
        end

        # All value methods from entries
        #
        # @return [Array<Symbol>]
        def entries_value
          entries.map { |e| e[:value] }.compact
        end

        # All help fields from entries
        #
        # @return [Array<Symbol>]
        def entries_help
          entries.map { |e| e[:help] }.compact
        end
      end
    end
  end
end

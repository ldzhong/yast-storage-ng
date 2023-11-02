#!/usr/bin/env rspec
#
# encoding: utf-8

# Copyright (c) [2023] SUSE LLC
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

require_relative "spec_helper"
require "y2storage/yast_feature"

describe Y2Storage::YastFeature do
  describe "eql?" do
    # Pretty trivial test now that we only have one feature, to be improved in the future
    it "returns true when comparing the same feature" do
      expect(Y2Storage::YastFeature.all.first).to eq Y2Storage::YastFeature::ENCRYPTION_TPM_FDE
    end
  end
end

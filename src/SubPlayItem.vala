/*
 * BluRay - a simple sample implementation of Blu-ray Disc specifications
 * Copyright (C) 2011  Luca Wehrstedt

 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.

 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace BluRay
{
	class SubPlayItem : Object
	{
		public string ClipInformationFileName { get; set; }

		public string ClipCodecIdentifier { get; set; }

		public uint8 ConnectionCondition { get; set; }

		public uint8 IsMultiClipEntries { get; set; }

		public uint8 RefToSTCID { get; set; }

		public uint32 INTime { get; set; }

		public uint32 OUTTime { get; set; }

		public uint16 SyncPlayItemID { get; set; }

		public uint32 SyncStartPTS { get; set; }

		public SubPlayItem.from_bit_input_stream (BitInputStream input_stream) throws ParseError
		{
			try
			{
				uint16 Length = input_stream.read_bits_as_uint16 (16);

				int64 Position = input_stream.tell (); // Needed to seek

				ClipInformationFileName = input_stream.read_string (5);
				ClipCodecIdentifier = input_stream.read_string (4);

				input_stream.skip_bits (27);

				ConnectionCondition = input_stream.read_bits_as_uint8 (4);
				IsMultiClipEntries = input_stream.read_bits_as_uint8 (1);
				RefToSTCID = input_stream.read_bits_as_uint8 (8);
				INTime = input_stream.read_bits_as_uint32 (32);
				OUTTime = input_stream.read_bits_as_uint32 (32);
				SyncPlayItemID = input_stream.read_bits_as_uint16 (16);
				SyncStartPTS = input_stream.read_bits_as_uint32 (32);

				// TODO: MultiClipEntries

				input_stream.seek (Position + Length);
			}
			catch (IOError e)
			{
				throw new ParseError.INPUT_ERROR ("Couldn't parse SubPlayItem.");
			}
		}

//		public void write (BitOutputStream output_stream)
//		{
//		}
	}
}


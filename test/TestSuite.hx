import massive.munit.TestSuite;

import logging.FormatterTest;
import logging.LogRecordTest;
import logging.ManagerTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(logging.FormatterTest);
		add(logging.LogRecordTest);
		add(logging.ManagerTest);
	}
}

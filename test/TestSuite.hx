import massive.munit.TestSuite;

import logging.FilterTest;
import logging.FormatterTest;
import logging.LoggerTest;
import logging.LoggingTest;
import logging.LogRecordTest;
import logging.ManagerTest;
import logging.SocketHandlerTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(logging.FilterTest);
		add(logging.FormatterTest);
		add(logging.LoggerTest);
		add(logging.LoggingTest);
		add(logging.LogRecordTest);
		add(logging.ManagerTest);
		add(logging.SocketHandlerTest);
	}
}

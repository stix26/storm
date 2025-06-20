"""
Basic import tests for knowledge-storm package.
"""

import pytest


def test_knowledge_storm_import():
    """Test that the main package can be imported."""
    try:
        import knowledge_storm
        assert hasattr(knowledge_storm, '__version__')
        print(f"knowledge_storm version: {knowledge_storm.__version__}")
    except ImportError as e:
        pytest.fail(f"Failed to import knowledge_storm: {e}")


def test_interface_import():
    """Test that the interface module can be imported."""
    try:
        from knowledge_storm import interface
        assert interface is not None
    except ImportError as e:
        pytest.fail(f"Failed to import interface: {e}")


def test_lm_import():
    """Test that the lm module can be imported."""
    try:
        from knowledge_storm import lm
        assert lm is not None
    except ImportError as e:
        pytest.fail(f"Failed to import lm: {e}")


def test_rm_import():
    """Test that the rm module can be imported."""
    try:
        from knowledge_storm import rm
        assert rm is not None
    except ImportError as e:
        pytest.fail(f"Failed to import rm: {e}")


def test_dataclass_import():
    """Test that the dataclass module can be imported."""
    try:
        from knowledge_storm import dataclass
        assert dataclass is not None
    except ImportError as e:
        pytest.fail(f"Failed to import dataclass: {e}")


def test_utils_import():
    """Test that the utils module can be imported."""
    try:
        from knowledge_storm import utils
        assert utils is not None
    except ImportError as e:
        pytest.fail(f"Failed to import utils: {e}")


def test_encoder_import():
    """Test that the encoder module can be imported."""
    try:
        from knowledge_storm import encoder
        assert encoder is not None
    except ImportError as e:
        pytest.fail(f"Failed to import encoder: {e}")


def test_logging_wrapper_import():
    """Test that the logging_wrapper module can be imported."""
    try:
        from knowledge_storm import logging_wrapper
        assert logging_wrapper is not None
    except ImportError as e:
        pytest.fail(f"Failed to import logging_wrapper: {e}")


def test_storm_wiki_import():
    """Test that the storm_wiki module can be imported."""
    try:
        from knowledge_storm import storm_wiki
        assert storm_wiki is not None
    except ImportError as e:
        pytest.fail(f"Failed to import storm_wiki: {e}")


def test_collaborative_storm_import():
    """Test that the collaborative_storm module can be imported."""
    try:
        from knowledge_storm import collaborative_storm
        assert collaborative_storm is not None
    except ImportError as e:
        pytest.fail(f"Failed to import collaborative_storm: {e}")


if __name__ == "__main__":
    pytest.main([__file__]) 